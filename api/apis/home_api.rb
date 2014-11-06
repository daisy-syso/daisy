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
      subtitle: "位置"
    }
  end

  TypeMenu = [{
      title: "热门精选",
      url: "coupons/coupons"
    }, {
      title: "医院大全",
      url: "hospitals/hospitals",
      children: [{
        id: 1000,
        title: "全部",
        parent: true
      }, {
        title: "综合医院",
        children: [{
          title: "全部",
          parent: true
        }, {
          title: "三级甲等"
        }, {
          title: "三级乙等"
        }, {
          title: "三级合格"
        }, {
          title: "二级甲等"
        }, {
          title: "二级乙等"
        }, {
          title: "二级合格"
        }, {
          title: "一级甲等"
        }, {
          title: "一级乙等"
        }, {
          title: "一级合格"
        }, {
          title: "社区医院"
        }, {
          title: "民营医院"
        }, {
          title: "外资医院"
        }, {
          title: "社保定点医院"
        }, {
          title: "综合医院诊疗攻略"
        }, {
          title: "综合医院价格攻略"
        }]
      }, { 
        title: "全国体检",
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
          title: "体检套餐攻略"
        }, {
          title: "体检价格攻略"
        }]
      }, {
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
          title: "整形美容诊疗攻略"
        }, {
          title: "整形美容价格攻略"
        }]
      }, {
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
          title: "牙科诊疗攻略"
        }, {
          title: "牙科价格攻略"
        }]
      }, {
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
          title: "妇科诊疗攻略"
        }, { 
          title: "妇科价格攻略"
        }]
      }, {
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
          title: "男科诊疗攻略"
        }, {
          title: "男科价格攻略"
        }]
      }, {
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
          title: "中医诊疗攻略"
        }, {
          title: "中医价格攻略"
        }]
      }]
    }, {
      title: "查疾病",
      url: "diseases/diseases",
      children: [{
        id: 2000,
        title: "全部",
        parent: true
      }, {
        title: "症状查疾病",
      }, {
        title: "科室查疾病",
      }, {
        title: "字母查疾病",
      }, {
        title: "药品查疾病",
      }]
    }, {
      title: "找医生",
      url: "hospitals/doctors",
      children: [{
        id: 3000,
        title: "全部",
        parent: true
      }, {
        title: "医院找医生",
      }, {
        title: "科室找医生",
      }, {
        title: "疾病找医生",
      }, {
        title: "字母找医生",
      }, {
        title: "找专家医生攻略"
      }]
    }, {
      title: "药品大全",
      url: "drugs/drugs",
      children: [{
        id: 4000,
        title: "全部",
        parent: true
      }, {
        title: "疾病查药品",
      }, {
        title: "科室查药品",
      }, {
        title: "医生查药品",
      }, {
        title: "字母查药品",
      }, {
        title: "医保定点药品"
      }]
    }, {
      title: "身边药房",
      url: "drugs/drugstores",
      children: [{
        id: 5000,
        title: "全部",
        parent: true
      }, {
        title: "字母找药店",
      }, {
        title: "地图找药店",
      }, {
        title: "医保定点药店"
      }]
    }, {
      title: "医保查询",
      children: [{
        id: 6000,
        title: "医保查询",
        url: "social_securities/social_securities"
      }, {
        title: "定点医院查询",
        url: "social_securities/social_security_hospitals"
      }, {
        title: "定点药店查询",
        url: "social_securities/social_security_drugstores"
      }, {
        title: "定点药品查询",
        url: "social_securities/social_security_drugs"
      }, {
        title: "健康险攻略"
      }]
    }, {
      title: "价格搜索",
      children: [{
        id: 7000,
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
      title: "全国体检",
      url: "examinations/examinations",
      children: [{
        id: 8000,
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
        id: 9000,
        title: "养老公寓",
        url: :"eldercares/nursing_rooms"
      }, {
        title: "养老保险（社保）查询",
        url: :"eldercares/social_security_endowments"
      }, {
        title: "养老保险（商业）攻略",
        url: :"eldercares/insurances"
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
        node[:url] ||= parent[:url]
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