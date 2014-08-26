class PriceSearchAPI < Grape::API

  params do
    optional :type, type: String, default: "drug"
    optional :disease, type: Integer
    optional :shaping_type, type: Integer
  end
  get :price_search do

    case params[:type]
    when "drug"
      has_scope :disease
      data = apply_scopes!(Drugs::Drug.all)
      current = params[:disease] ? Drugs::Disease.find(params[:disease]).name : "全部"
    when "shaping"
      has_scope :shaping_type
      data = apply_scopes!(Shapings::ShapingItem.all)
      current = Shapings::ShapingType.find(params[:shaping_type]).name
    end

    append_params = proc do |filters, append_params|
      filters.map do |filter|
        filter[:params].merge! append_params if filter[:params]
        filter
      end
    end

    append_children = proc do |filters, append_children|
      filters.map do |filter|
        filter[:params].merge! append_params if filter[:params]
        filter
      end
    end

    filters = [{
      title: "类别", 
      children: [{
        title: "药品",
        children: append_params.call(Drugs::Disease.filters_without_cache, 
          type: :drug)
      }, {
        title: "整形",
        children: append_params.call(Shapings::ShapingType.filters_without_cache, 
          type: :shaping)
      }],
      current: current
    }, {
      title: "价格",
      children: [],
      current: "全部" 
    }]

    present! data, meta: { filters: filters, title: "价格搜索" }
  end

end