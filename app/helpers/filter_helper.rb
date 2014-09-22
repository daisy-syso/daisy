module FilterHelper

  def price_filters klass

    price_title = proc do |from, to = nil|
      to ? "#{from} ~ #{to} 元" : "#{from} 元 以上"
    end

    { 
      title: "价格区间", 
      type: Hash,
      using: [:from, :to],
      children: proc {
        prices = Setting["price_search.#{klass.table_name}.filters.price"]
        filters = prices.each_cons(2).map do |from, to|
          Hash.new.tap do |ret|
            ret[:title] = price_title.call from, to
            ret[:params] = { "price[from]" => from, "price[to]" => to }
          end
        end
        last = Hash.new.tap do |ret|
          ret[:title] = price_title.call prices.last
          ret[:params] = { "price[from]" => prices.last, "price[to]" => nil }
        end
        filters + [ last ]
      }, 
      current: proc { |price| 
        price ? price_title.call(price[:from], price[:to]) : "全部"
      }
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

  def order_by_filters klass
    {
      title: "排序",
      type: String,
      current: proc { |id|
        id ? OrderByMap[id.to_sym] : "智能排序"
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
          collection
        end
      }
    }
  end

end
