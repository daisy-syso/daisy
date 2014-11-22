class HomeAPI < Grape::API

  get :home do
    {
      buttons: [{
        title: "医院大全",
        link: "#/list/hospitals/hospitals",
        icon: "images/icons/1-1.gif"
      }, {
        title: "疾病查询",
        link: "#/list/diseases/diseases",
        icon: "images/icons/1-2.gif"
      }, {
        title: "找医生",
        link: "#/list/hospitals/doctors",
        icon: "images/icons/1-3.gif"
      }, {
        title: "手机挂号",
        link: "#/list/hospitals/registrations",
        icon: "images/icons/1-4.gif"
      }, {
        title: "药品大全",
        link: "#/list/drugs/drugs",
        icon: "images/icons/1-5.gif"
      }, {
        title: "身边药房",
        link: "#/list/drugs/drugstores",
        icon: "images/icons/1-6.gif"
      }, {
        title: "医保查询",
        link: "#/list/social_securities/social_securities",
        icon: "images/icons/1-7.gif"
      }, {
        title: "价格搜索",
        link: "#/list/price_search/drugs",
        icon: "images/icons/1-8.gif"
      # }, {
      #   title: "热门专科",
      #   link: "#/list/hospitals/specialists",
      #   icon: "images/icons/1-9.gif"
      # }, {
      #   title: "热门诊所",
      #   link: "#/home",
      #   icon: "images/icons/1-10.gif"
      }, {
        title: "全国体检",
        link: "#/list/examinations/examinations",
        icon: "images/icons/2-3.gif"
      }, {
        title: "养老服务",
        link: "#/list/eldercares/nursing_rooms",
        icon: "images/icons/2-5.gif"
      # }, {
      #   title: "月子中心",
      #   link: "#/list/maternals/confinement_centers",
      #   icon: "images/icons/2-10.gif"
      # }, {
      #   title: "母婴会馆",
      #   link: "#/list/maternals/maternal_halls",
      #   icon: "images/icons/2-11.gif"
      # }, {
      #   title: "返利优惠",
      #   link: "#/list/coupons/drugs",
      #   icon: "images/icons/1-11.gif"
      }],
      subtitle: {
        key: :city,
        keep: :city, 
        title: "位置",
        link: "categories/cities"
      }
    }
  end

  TypeMenu = [{
      type: "coupons/coupons",
      title: "热门精选"
    }, {
      title: "医院大全",
      children: [{
        type: "hospitals/polyclinics",
        title: "综合医院",
        children: [{
          id: :polyclinic,
          title: "全部",
          parent: true
        }, {
          title: "三级甲等",
          params: { hospital_level: 8 }
        }, {
          title: "三级乙等",
          params: { hospital_level: 9 }
        }, {
          title: "三级合格",
          params: { hospital_level: 10 }
        }, {
          title: "二级甲等",
          params: { hospital_level: 4 }
        }, {
          title: "二级乙等",
          params: { hospital_level: 5 }
        }, {
          title: "二级合格",
          params: { hospital_level: 6 }
        }, {
          title: "一级甲等",
          params: { hospital_level: 1 }
        }, {
          title: "一级乙等",
          params: { hospital_level: 2 }
        }, {
          title: "一级合格",
          params: { hospital_level: 3 }
        }, {
          title: "社区医院",
          params: { hospital_level: 13 }
        }, {
          title: "民营医院",
          params: { hospital_level: 11 }
        }, {
          title: "外资医院",
          params: { hospital_level: 12 }
        }, {
          type: "social_securities/social_securities",
          title: "社保定点医院",
          params: { social_security_type: 2 }
        }, {
          type: "hospitals/polyclinic_treatments",
          title: "综合医院诊疗攻略"
        }, {
          type: "hospitals/polyclinic_charges",
          title: "综合医院价格攻略"
        }]
      }, { 
        type: "hospitals/tests",
        title: "体检医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "热门体检"
        }, {
          title: "商务体检套餐"
        }, {
          title: "肿瘤检测"
        }, {
          title: "高发疾病检测"
        }, {
          title: "适用人群套餐"
        }, {
          type: "hospitals/hospital_news",
          title: "体检诊疗攻略",
          params: { hospital_type: 3 }
        }, {
          type: "examinations/examinations",
          title: "体检价格攻略"
        }]
      }, {
        type: "hospitals/plastics",
        title: "整形医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "眼部整形"
        }, {
          title: "鼻部整形"
        }, {
          title: "口腔整形"
        }, {
          title: "胸部整形"
        }, {
          title: "抽脂"
        }, {
          title: "毛发"
        }, {
          title: "拉皮"
        }, {
          title: "脂肪移植"
        }, {
          title: "面部轮廓"
        }, {
          title: "肉毒素"
        }, {
          title: "填充"
        }, {
          title: "其它"
        }, {
          title: "皮肤"
        }, {
          title: "半永久性化妆"
        }, {
          type: "hospitals/hospital_news",
          title: "整形美容诊疗攻略",
          params: { hospital_type: 2 }
        }, {
          type: "shapings/shaping_items",
          title: "整形美容价格攻略"
        }]
      }, {
        type: "hospitals/dentals",
        title: "牙科医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "号源"
        }, {
          title: "洗牙"
        }, {
          title: "烤瓷牙"
        }, {
          title: "牙齿矫正"
        }, {
          title: "隐形矫正"
        }, {
          title: "拔牙"
        }, {
          title: "根管治疗"
        }, {
          title: "活动义齿"
        }, {
          title: "全口义齿"
        }, {
          type: "hospitals/hospital_news",
          title: "牙科诊疗攻略",
          params: { hospital_type: 6 }
        }, {
          type: "hospitals/hospital_charges",
          title: "牙科价格攻略",
          params: { hospital_type: 6 }
        }]
      }, {
        type: "hospitals/gynaecologies",
        title: "妇幼医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "孕期检查"
        }, { 
          title: "无痛人流"
        }, { 
          title: "四维/三维"
        }, { 
          title: "妇科整形"
        }, { 
          title: "不孕不育"
        }, { 
          title: "妇科微创"
        }, { 
          title: "宫颈疾病手术"
        }, { 
          title: "痛经中心"
        }, { 
          type: "hospitals/hospital_news",
          title: "妇科诊疗攻略",
          params: { hospital_type: 5 }
        }, { 
          type: "hospitals/hospital_charges",
          title: "妇科价格攻略",
          params: { hospital_type: 5 }
        }]
      }, {
        type: "hospitals/andrologies",
        title: "男科医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "前列腺活检及治疗"
        }, {
          title: "前列腺癌根治术"
        }, {
          title: "男性生殖器常见手术"
        }, {
          title: "检查、治疗睾丸疾病"
        }, {
          title: "精索静脉曲张手术"
        }, {
          title: "隐睾治疗"
        }, {
          title: "男科整形"
        }, {
          title: "包皮手术"
        }, {
          type: "hospitals/hospital_news",
          title: "男科诊疗攻略",
          params: { hospital_type: 1 }
        }, {
          type: "hospitals/hospital_charges",
          title: "男科价格攻略",
          params: { hospital_type: 1 }
        }]
      }, {
        type: "hospitals/tcm",
        title: "中医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "中医推拿治疗"
        }, {
          title: "中医针灸治疗"
        }, {
          title: "其它"
        }, {
          type: "hospitals/hospital_news",
          title: "中医诊疗攻略",
          params: { hospital_type: 4 }
        }, {
          type: "hospitals/hospital_charges",
          title: "中医价格攻略",
          params: { hospital_type: 4 }
        }]
      }]
    }, {
      type: "diseases/diseases",
      title: "查疾病",
      children: [{
        id: :disease,
        title: "症状查疾病",
        params: { search_by: :symptom }
      }, {
        title: "科室查疾病",
        params: { search_by: :hospital_room }
      }, {
        title: "字母查疾病",
        params: { search_by: :alphabet }
      }]
    }, {
      type: "hospitals/doctors",
      title: "找医生",
      children: [{
        id: :doctor,
        title: "医院找医生",
        params: { search_by: :hospital }
      }, {
        title: "疾病找医生",
        params: { search_by: :disease }
      }, {
        title: "科室找医生",
        params: { search_by: :hospital_room }
      }, {
        title: "字母找医生",
        params: { search_by: :alphabet }
      }, {
        title: "找专家医生攻略"
      }]
    }, {
      type: "drugs/drugs",
      title: "药品大全",
      children: [{
        id: :drug,
        title: "疾病查药品",
        params: { search_by: :disease }
      }, {
        title: "科室查药品",
        params: { search_by: :hospital_room }
      }, {
        title: "字母查药品",
        params: { search_by: :alphabet }
      }, {
        type: "social_securities/social_securities",
        title: "医保定点药品",
        params: { social_security_type: 3 }
      }]
    }, {
      type: "drugs/drugstores",
      title: "身边药房",
      children: [{
        id: :drugstore,
        title: "字母找药店",
        params: { search_by: :alphabet }
      }, {
        title: "地图找药店",
        params: { search_by: :map }
      }, {
        type: "social_securities/social_securities",
        title: "医保定点药店",
        params: { social_security_type: 4 }
      }]
    }, {
      title: "医保查询",
      children: [{
        id: :social_security,
        type: "social_securities/social_securities",
        title: "医保查询",
        params: { social_security_type: 1 }
      }, {
        type: "social_securities/social_securities",
        title: "定点医院查询",
        params: { social_security_type: 2 }
      }, {
        type: "social_securities/social_securities",
        title: "定点药品查询",
        params: { social_security_type: 3 }
      }, {
        type: "social_securities/social_securities",
        title: "定点药店查询",
        params: { social_security_type: 4 }
      }, {
        title: "健康险攻略"
      }]
    }, {
      title: "价格搜索",
      children: [{
        id: :price_search,
        title: "综合医院价格攻略"
      }, {
        title: "整形医院价格攻略"
      }, {
        title: "牙科医院价格攻略"
      }, {
        title: "妇幼医院价格攻略"
      }, {
        title: "全国体检价格攻略"
      }, {
        title: "男科医院价格攻略"
      }, {
        title: "中医院价格攻略"
      }, {
        title: "药品价格查询"
      }, {
        title: "健康保险价格查询"
      }, {
        title: "养老保险价格查询"
      }, {
        title: "月子中心价格查询"
      }, {
        title: "母婴会馆价格查询"
      }, {
        title: "返利优惠"
      }, {
        title: "代金券"
      }]
    }, {
      type: "examinations/examinations",
      title: "全国体检",
      children: [{
        id: :examination,
        title: "全部",
        parent: true
      }, {
        title: "热门体检"
      }, {
        title: "商务体检套餐"
      }, {
        title: "肿瘤检测"
      }, {
        title: "高发疾病检测"
      }, {
        title: "适用人群套餐"
      }, {
        title: "体检套餐攻略"
      }, {
        title: "体检价格攻略"
      }]
    }, {
      title: "养老服务",
      children: [{
        id: :eldercare,
        type: :"eldercares/nursing_rooms",
        title: "养老公寓"
      }, {
        type: :"social_securities/social_securities",
        title: "养老保险（社保）查询",
        params: { social_security_type: 5 }
      }, {
        type: :"insurances/insurances",
        title: "养老保险（商业）攻略"
      }]
    }]

  class << self
    def next_id
      @id ||= 0
      @id += 1
    end

    def format_menu nodes, parent = {}
      nodes.each do |node|
        node[:id] ||= next_id
        node[:id] = node[:id].to_s
        format_menu node[:children], node if node[:children]
      end
    end
  end

  format_menu TypeMenu

  namespace :types do
    get :filters do
      TypeMenu
    end
  end

end