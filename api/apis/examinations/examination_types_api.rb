class Examinations::ExaminationTypesAPI < ApplicationAPI

  namespace :examination_type do
    index! Examinations::ExaminationType,
      title: "全国体检",
      filters: { 
        # city: city_filters,
        type: type_filters(:examination),
        examination_type: { scope_only: true },
        examination_parent_type: { scope_only: true },
        county: examination_parent_type,
        order_by: order_by_filters(Examinations::Examination),
        form: form_filters,
        query: form_query_filters,
        price: form_price_filters, 
        alphabet: form_alphabet_filters,
        hospital_query: form_radio_array_filters(
          %w(爱康国宾 美年大 慈铭体检 阳光体检), "品牌"),
        applicable_query: form_radio_array_filters(
          %w(男性 女性 白领 亚健康), "适应人群")
      }
      
    show! Examinations::Examination

  end
    #   params do
    #   requires :type, type: Integer
    # end
    # get :examination_type do
    #   examination_types = Examinations::ExaminationType.where(parent_id: params[:type]).page params[:page]
    #   # ets = append_url_to_filters examination_types, "examinations/"
    #   # p ets
    #   opts ={
    #   title: "价格搜索",
    #   filters: [
    #     {
    #         link: "types",
    #         key: "type",
    #         title: "全部类别",
    #         template: "list",
    #         current: "price_search"
    #     },{ 
    #     title: "商圈",
    #     children: Examinations::ExaminationType.where(parent_id: nil),
    #     filter_only: true
    #     },{
    #         "key" => "order_by",
    #         "title" => "智能排序",
    #         "template" => "list",
    #         "children" => [
    #             {
    #                 "title" => "智能排序",
    #                 "id" => "auto"
    #             },
    #             {
    #                 "title" => "最新发布",
    #                 "id" => "newest"
    #             }
    #         ],
    #         "current" => "auto"
    #     },
    #     {
    #         "template" => "form",
    #         "key" => "form",
    #         "title" => "筛选",
    #         "current" => nil,
    #         "children" => [
              
    #         ]
    #     }

    # ],
    # fin: true,
    # data: examination_types.as_json(Examinations::ExaminationType.demand_attrs)
    # }  
    #   # present! ets
    # end
end
