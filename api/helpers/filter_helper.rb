module FilterHelper
  extend ActiveSupport::Concern

  def parse_option_value *args
    value = args.pop
    if value.kind_of? Proc
      instance_exec *args, &value
    elsif value
      value
    elsif block_given?
      yield *args
    end
  end

  def generate_filter key, options
    filter = options[:meta] ? options[:meta].dup : {}
    filter[:template] ||= parse_option_value options[:template] do
      :list
    end
    filter[:children] ||= parse_option_value options[:children] do
      options[:class].filters
    end unless options[:nochildren]
    filter[:current] ||= parse_option_value params[key], options[:current] do |id|
      id ? options[:class].find(id).name : options[:title]
    end
    filter
  end

  def append_url_to_filters array, url
    array.each do |hash|
      hash[:url] = url if hash[:params]
      append_url_to_filters hash[:children], url if hash[:children]
    end
  end

  module ClassMethods

    def city_filters
      { 
        meta: { 
          keep: :city 
        },
        default: 1, 
        class: Categories::City, 
        title: "位置", 
        titleize: true
      }
    end

    def fake_city_filters
      { 
        meta: { 
          keep: :city 
        },
        default: 1, 
        class: Categories::City, 
        title: "位置", 
        titleize: true, 
        filter_only: true
      }
    end

    def price_filters
      { 
        type: Hash,
        using: [:from, :to],
        scope_only: true
      }
    end

    def zone_filters
      { 
        meta: { 
          current: "商圈",
        },
        children: proc { Categories::County.filters(params[:city]) },
      }
    end

    def fake_zone_filters
      { 
        meta: { 
          current: "商圈",
        },
        children: proc { Categories::County.filters(params[:city]) },
        filter_only: true
      }
    end

    def form_filters
      {
        meta: { 
          template: :form,
          current: "筛选",
        },
        nochildren: true,
        filter_only: true
      }
    end

    def form_radio_filters klass, title, key
      { 
        title: title, 
        template: :radio,
        current: proc { params[key] },
        children: proc { klass.form_filters },
        append: :form 
      }
    end

    def form_query_filters title = "搜索", key = :query
      {
        title: title, 
        template: :string,
        type: String,
        current: proc { params[key] },
        nochildren: true,
        append: :form,
      }
    end

    def form_alphabet_filters
      {
        title: "字母搜索", 
        template: :alphabet,
        type: String,
        current: proc { params[:alphabet] },
        nochildren: true,
        append: :form,
        filter_only: true
      }
    end

    def form_switch_filters title, key
      {
        title: title,
        type: Object,
        template: :switch,
        current: proc { params[key] == "true" },
        nochildren: true,
        append: :form
      }
    end

    def type_filters hash, current = nil
      
      hash = Hash[hash.map do |key, value| 
        [key, value.is_a?(Hash) ? value : { title: value, url: key }] 
      end]

      { 
        type: String,
        current: proc do |id|
          value = hash.values.find do |value|
            params[value[:id]]
          end
          if value
            value[:class].find(params[value[:id]]).name
          elsif hash[current]
            hash[current][:title]
          else
            "类别"
          end
        end,
        children: proc do
          filters = []
          hash.each do |key, options|
            parse_option_value filters, options[:children] do
              if options[:class]
                filters.push(title: options[:title], 
                  children: append_url_to_filters(options[:class].filters, key))
              else
                filters.push(options)
              end
            end
          end
          filters
        end,
        filter_only: true
      }
    end

    OrderByMap = {
      auto: "智能排序",
      nearest: "离我最近",
      favoriest: "评价最高",
      hotest: "人气最高",
      newest: "最新发布",
      cheapest: "价格最低",
      most_expensive: "价格最高"
    }

    def order_by_filters klass, options = {}
      {
        default: options[:default] || :auto,
        type: String,
        current: proc do |id|
          OrderByMap[id.to_sym] || parse_option_value(id, options[:current])
        end,
        children: proc do
          filters = []
          filters << { title: "智能排序" , params: { order_by: :auto }}
          if klass < Localizable && params[:location]
            filters << { title: "离我最近" , params: { order_by: :nearest }}
          end
          if klass < Reviewable
            filters << { title: "评价最高" , params: { order_by: :favoriest }}
            filters << { title: "人气最高" , params: { order_by: :hotest }}
          end
          filters << { title: "最新发布" , params: { order_by: :newest }}
          if klass.attribute_names.include? "sale_price"
            filters << { title: "价格最低" , params: { order_by: :cheapest }}
            filters << { title: "价格最高" , params: { order_by: :most_expensive }}
          end
          parse_option_value filters, options[:children]
          filters
        end,
        has_scope: proc do |endpoint, collection, key|
          case key.to_sym
          when :auto
            collection
          when :nearest
            params = endpoint.params
            lat = params["location:lat"]
            lng = params["location:lng"]
            collection.nearest(lat, lng)
          when :favoriest
            collection.order(star: :desc)
          when :hotest
            collection.order(reviews_count: :desc)
          when :newest
            collection.order(created_at: :desc)
          when :cheapest
            collection.order(sale_price: :asc)
          when :most_expensive
            collection.order(sale_price: :desc)
          else
            if options[:has_scope]
              instance_exec endpoint, collection, key, &options[:has_scope]
            else
              collection
            end
          end
        end
      }
    end

    def hospital_order_by_filters
      order_by_filters Hospitals::Hospital, {
        current: proc do |id|
          "医院等级" if id.to_sym == :hospital_level
        end,
        children: proc do |filters|
          filters.insert(1, { title: "医院等级" , params: { order_by: :hospital_level }})
        end,
        has_scope: proc do |endpoint, collection, key|
          if key.to_sym == :hospital_level
            collection.hospital_level
          else
            collection
          end
        end
      }
    end

    def price_search_order_by_filters klass

      price_title = proc do |from, to = nil|
        to ? "#{from} ~ #{to} 元" : "#{from} 元 以上"
      end

      order_by_filters klass, {
        current: proc do |id|
          price = params[:price]
          price ? price_title.call(price[:from], price[:to]) : "价格区间"
        end,
        children: proc do |filters|
          prices = Setting["price_search.#{klass.table_name}.filters.price"]
          children = prices.each_cons(2).map do |from, to|
            Hash.new.tap do |ret|
              ret[:title] = price_title.call from, to
              ret[:params] = { "price[from]" => from, "price[to]" => to }
            end
          end
          last = Hash.new.tap do |ret|
            ret[:title] = price_title.call prices.last
            ret[:params] = { "price[from]" => prices.last, "price[to]" => nil }
          end
          children.push last
          filters.push({ title: "价格区间" , children: children})
        end
      }
    end
  end

end
