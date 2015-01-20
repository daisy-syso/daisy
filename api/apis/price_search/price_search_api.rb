class PriceSearch::PriceSearchAPI < ApplicationAPI

	get :strategy_list do
		{
      title: "价格搜索",
      filters: [
        {
            link: "types",
            key: "type",
            title: "全部类别",
            template: "list",
            current: "price_search"
        },{ 
        title: "类别",
        children: Categories::County.filters(params[:city]),
        filter_only: true
        },{
            "key" => "order_by",
            "title" => "智能排序",
            "template" => "list",
            "children" => [
                {
                    "title" => "智能排序",
                    "id" => "auto"
                },
                {
                    "title" => "最新发布",
                    "id" => "newest"
                }
            ],
            "current" => "auto"
        },
        {
            "template" => "form",
            "key" => "form",
            "title" => "筛选",
            "current" => nil,
            "children" => [
              
            ]
        }

    ],
    fin: true,
      data: [{
        template: "price_search/strategy_list",
        url:  "#/list/hospitals/polyclinic_charges?type=price_search",
        id: :price_search,
        type: "hospitals/polyclinic_charges",
        title: "综合医院价格攻略"
      }, {
        template: "price_search/strategy_list",
        # template: "examinations/examination_type.html.erb",
        # url: "#/list/examinations/examinations?type=133",
        url: "#/list/examinations/examination_type",
        type: "examinations/examinations",
        title: "全国体检价格攻略"
      }, {
        template: "price_search/strategy_list",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=2&type=134",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=2",
        url: "#/list/hospitals/hospital_types?hospital_parent_type=2",
        type: "hospitals/hospital_charges",
        title: "整形医院价格攻略",
        params: { hospital_parent_type: 2 }
      }, {
        template: "price_search/strategy_list",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=6&type=135",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=6",
        url: "#/list/hospitals/hospital_types?hospital_parent_type=6",
        type: "hospitals/hospital_charges",
        title: "牙科医院价格攻略",
        params: { hospital_parent_type: 6 }
      }, {
        template: "price_search/strategy_list",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=5&type=136",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=5",
        url: "#/list/hospitals/hospital_types?hospital_parent_type=5",
        type: "hospitals/hospital_charges",
        title: "妇幼医院价格攻略",
        params: { hospital_parent_type: 5 }
      }, {
        template: "price_search/strategy_list",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=1&type=137",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=1",
        url: "#/list/hospitals/hospital_types?hospital_parent_type=1",
        type: "hospitals/hospital_charges",
        title: "男科医院价格攻略",
        params: { hospital_parent_type: 1 }
      }, {
        template: "price_search/strategy_list",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=4&type=138",
        # url: "#/list/hospitals/hospital_charges?hospital_parent_type=4",
        url: "#/list/hospitals/hospital_types?hospital_parent_type=4",
        type: "hospitals/hospital_charges",
        title: "中医院价格攻略",
        params: { hospital_parent_type: 4 }
      }, {
        template: "price_search/strategy_list",
        url: "#/list/drugs/drugs?type=139",
        type: "drugs/drugs",
        title: "药品价格查询"
      }, {
        template: "price_search/strategy_list",
        # url: "#/list/insurances/insurances?type=8436",
        url: "#/list/insurances/commercial_insurances",
        type: :"insurances/commercial_insurances",
        title: "健康保险价格查询"
      }, {
        template: "price_search/strategy_list",
        url: "#/list/insurances/insurances?type=8435",
        type: :"insurances/insurances",
        title: "养老保险价格查询"
      }, {
        template: "price_search/strategy_list",
        url: "##/list/maternals/confinement_centers?type=142",
        type: :"maternals/confinement_centers",
        title: "月子中心价格查询"
      }, {
        template: "price_search/strategy_list",
        url: "#/list/price_search/strategy_list?type=143",
        title: "返利优惠"
      }, {
        template: "price_search/strategy_list",
        url: "#/list/examinations/examinations?type=133",
        title: "代金券"
      }]
    }    
	end

end

