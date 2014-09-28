module FilterHelper

  def city_filters
    { 
      default: 1, 
      class: Categories::City, 
      title: "位置", 
      titleize: true, 
      meta: { keep: :city }
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
        children: [],
      },
      filter_only: true
    }
  end

  def form_filters template, current
    {
      meta: { 
        template: template,
        current: current,
        children: [],
      },
      filter_only: true
    }
  end

  def type_filters hash, current = nil

    children_url = proc do |array, url|
      array.each do |hash|
        hash[:url] = url if hash[:params]
        children_url.call(hash[:children], url) if hash[:children]
      end
    end

    { 
      type: String,
      current: proc { |id|
        value = hash.values.find do |value|
          value.is_a?(Hash) && params[value[:id]]
        end
        next value[:class].find(params[value[:id]]).name if value
        if hash[current]
          if hash[current].is_a?(Hash) 
            hash[current][:title]
          else
            hash[current]
          end
        else
          "类别"
        end
      },
      children: proc {
        hash.map do |key, value|
          case value
          when String
            { title: value, url: key }
          when Hash
            {
              title: value[:title],
              children: children_url.call(value[:class].filters, key)
            }
          end
        end
      },
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
      default: :auto,
      type: String,
      current: proc { |id|
        OrderByMap[id.to_sym] || if options[:current]
          instance_exec(id, &options[:current])
        end
      },
      children: proc {
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
        instance_exec(filters, &options[:children]) if options[:children]
        filters
      },
      has_scope: proc { |endpoint, collection, key|
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
            instance_exec(endpoint, collection, key, &options[:has_scope])
          else
            collection
          end
        end
      }
    }
  end

  def hospital_order_by_filters
    order_by_filters Hospitals::Hospital, {
      current: proc { |id|
        "医院等级" if id.to_sym == :level
      },
      children: proc { |filters|
        filters.insert(1, { title: "医院等级" , params: { order_by: :level }})
      },
      has_scope: proc { |endpoint, collection, key|
        if key.to_sym == :level
          collection.order(level: :desc)
        else
          collection
        end
      }
    }
  end

  def price_search_order_by_filters klass

    price_title = proc do |from, to = nil|
      to ? "#{from} ~ #{to} 元" : "#{from} 元 以上"
    end

    order_by_filters klass, {
      current: proc { |id|
        price = params[:price]
        price ? price_title.call(price[:from], price[:to]) : "价格区间"
      },
      children: proc { |filters|
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
      }
    }
  end

end
