class Examinations::ExaminationsAPI < ApplicationAPI

  namespace :examinations do

    index! Examinations::Examination,
      title: "全国体检",
      filters: {
        city: city_filters,
        type: type_filters("全国体检", :examination),
        search_by: search_by_filters({
          default: :examination,
          examination: common_examination_filters
        }),
        order_by: order_by_filters(Examinations::Examination),
        form: form_filters,
        query: form_query_filters,
        price: form_price_filters
        # examination_types: fake_exapination_types
        # need_order: form_switch_filters("无需预约"),
        # has_return: form_switch_filters("返现"),
        # theme: form_radio_array_filters(%w(不限 基础体检 单位团体体检 常规体检 婚前体检 孕前体检 儿童体检 老年体检 妇科体检 青年体检 精英体检 高端体检), "当前主题精选"),
        # hospital_query: form_radio_array_filters(
        #   %w(爱康国宾 美年大 慈铭体检 阳光体检), "品牌"),
        # applicable_query: form_radio_array_filters(
        #   %w(男性 女性 白领 亚健康), "适应人群")
        # price_type:form_radio_array_filters(%w(不限 299元以下 300-599元 600-1000元 1000-1999元 2000-3999元 4000元以上), "价格排列按钮")
      }

    show! Examinations::Examination
    # get do
    #   examination_type_id = params[:type]
    #   city_id = params[:city] || 1
    #   @examinations = Examinations::Examination.types(examination_type_id).city(city_id).page(params[:page])
    #   present title: "全国体检"
    #   present filters: [
    #                       {
    #                           link: "types",
    #                           key: "type",
    #                           title: "全国体检",
    #                           template: "list",
    #                           current: "examination"
    #                       },{
    #                         title: "体检类别",
    #                         children: Examinations::ExaminationType.generate_attrs,
    #                         template: "list",
    #                         filter_only: true,
    #                         current: 1,
    #                         key: "type"
    #                       },
    #                       {
    #                           key: "order_by",
    #                           title: "智能排序",
    #                           template: "list",
    #                           children: [
    #                               {
    #                                   title: "智能排序",
    #                                   id: "auto"
    #                               },
    #                               {
    #                                   title: "最新发布",
    #                                   id: "newest"
    #                               }
    #                           ],
    #                           current: "auto"
    #                       },
    #                       {
    #                           template: "form",
    #                           key: "form",
    #                           title: "筛选",
    #                           current: nil,
    #                           children: []
    #                       }
    #                     ]

    #     present subtitle: {
    #                           title: "位置",
    #                           link: "categories/cities",
    #                           key: 'city',
    #                           template: "list",
    #                           children: Categories::City.all,
    #                           default: 1
    #                       }

    #     present :data, @examinations, with: Examinations::ExaminationEntity
    # end
    # show! Examinations::Examination
  end



end
