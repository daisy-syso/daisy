class HomeAPI < Grape::API

  get :home do
    btns = {
      buttons: [{
        title: "医院大全",
        # link: "#/list/hospitals/all?type=3",
        link: "#/list/hospitals/polyclinics?type=polyclinic&country=1",
        icon: "images/icons/1-1.png"
      }, {
        title: "疾病查询",
        link: "#/list/diseases/diseases?search_by=common_disease&type=134&common_disease=8",
        icon: "images/icons/1-2.png"
      }, {
        title: "找医生",
        link: "#/list/hospitals/doctors",
        icon: "images/icons/1-3.png"
      }, {
        title: "诊疗攻略",
        link: "#/list/price_search/strategy_list",
        # title: "手机挂号",
        # link: "#/list/hospitals/polyclinics",
        icon: "images/icons/1-4.png"
      }, {
        title: "药品大全",
        link: "#/list/drugs/drugs",
        icon: "images/icons/1-5.png"
      }, {
        title: "身边药房",
        link: "#/list/drugs/drugstores",
        icon: "images/icons/1-6.png"
      }, {
        title: "养老服务",
        link: "#/list/eldercares/nursing_rooms",
        # title: "医保查询",
        # link: "#/list/social_securities/social_securities",
        icon: "images/icons/1-7.png"
      }, {
        title: "全部类别",
        link: "#/list/menus",
        # title: "价格搜索",
        # link: "#/list/price_search/drugs",
        # link: "#/list/price_search/strategy_list",
        icon: "images/icons/1-8.png"
      }, {
        title: "特色科室",
        link: "#/list/hospitals/characteristics",
        icon: "images/icons/2-1.png"
      }, {
        title: "团购优惠",
        link: "#/privileges/hospitals",
        icon: "images/icons/2-2.png"
      }, {
        title: "全国体检",
        link: "#/list/examinations/examinations",
        icon: "images/icons/2-3.png"
      }, {
        # title: "医保查询",
        title: "最新优惠",
        # link: "#/list/eldercares/nursing_rooms",
        link: "#/privileges/newest",
        icon: "images/icons/2-4.png"
      }, {
        title: "症状查询",
        link: "#/list/symptoms/symptoms",
        icon: "images/icons/2-5.png"
      }, {
        title: "母婴亲子",
        # link: "#/list/maternals/maternal_halls",
        link: "#/privileges/maternals/confinement_centers",
        icon: "images/icons/2-6.png"
      }, {
        title: "海外医疗",
        link: "#/list/hospitals/overseas?country=2",
        icon: "images/icons/2-7.png"
      }, {
        title: "疾病保险",
        link: "#/privileges/insurances",
        icon: "images/icons/2-8.png"
      # }
      # }, {
      #   title: "热门专科",
      #   link: "#/list/hospitals/specialists",
      #   icon: "images/icons/1-9.png"
      # }, {
      #   title: "热门诊所",
      #   link: "#/home",
      #   icon: "images/icons/1-10.png"
      # }, {
      #   title: "全国体检",
      #   link: "#/list/examinations/examinations",
      #   icon: "images/icons/2-3.png"
      # }, {
      #   title: "养老服务",
      #   link: "#/list/eldercares/nursing_rooms",
      #   icon: "images/icons/2-5.png"
      # }, {
      #   title: "月子中心",
      #   link: "#/list/maternals/confinement_centers",
      #   icon: "images/icons/2-10.png"
      # }, {
      #   title: "母婴会馆",
      #   link: "#/list/maternals/maternal_halls",
      #   icon: "images/icons/2-11.png"
      # }, {
      #   title: "返利优惠",
      #   link: "#/list/coupons/drugs",
      #   icon: "images/icons/1-11.png"
      }],
      subtitle: {
        key: :city,
        keep: :city, 
        title: "位置",
        link: "categories/cities"
      }
    }

    pictur_health_infors = Informations::HealthInformation.picture_infors
    title_health_infors = Informations::HealthInformation.title_infors
    
    present btns
    present :pictur_infors, pictur_health_infors
    present :title_infors, title_health_infors
  end

  namespace :home do 
    get :menus do
      
      
    end

  end 

  def type_menu(city) 
   [{
      type: "coupons/coupons",
      title: "热门精选",
    #  count: 0
    }, {
      title: "医院大全",
    #  count: Hospitals::Hospita#l.count,
      children: [{
        # type: "hospitals/all?type=3",
        title: "全部分类"
        }, {
        type: "hospitals/polyclinics",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_Complex.png",
        title: "综合医院",
        children: [{
          id: :polyclinic,
          title: "全部医院",
          filterTitle: "综合医院"
        }, {
          title: "三级甲等",
        #  count: Hospitals::Hospital.where(hospital_level: 2, city_id: city#).count,
          params: { hospital_level: 2 }
        }, {
          title: "三级乙等",
          params: { hospital_level: 3 }
        }, {
          title: "三级合格",
          params: { hospital_level: 4 }
        }, {
          title: "二级甲等",
        #  count: 3456,
          params: { hospital_level: 5 }
        }, {
          title: "二级乙等",
        #  count: 3456,
          params: { hospital_level: 6 }
        }, {
          title: "二级合格",
        #  count: 3456,
          params: { hospital_level: 7 }
        }, {
          title: "一级甲等",
        #  count: 3456,
          params: { hospital_level: 8 }
        }, {
          title: "一级乙等",
        #  count: 3456,
          params: { hospital_level: 9 }
        }, {
          title: "一级合格",
        #  count: 3456,
          params: { hospital_level: 10 }
        }, {
          title: "外资医院",
        #  count: 3456,
          params: { is_foreign: true }
          
        }, {
          title: "社区医院",
        #  count: 3456,
          params: { is_community: true }
        }, {
          title: "其他医院",
        #  count: 3456,
          params: { is_other: true }
        }, {
          type: "social_securities/social_securities",
          title: "社保定点医院",
        #  count: 3456,
          params: { social_security_type: 2 }
        }, {
          type: "raiders/raider_details",
        #  count: 3456,
          title: "综合医院诊疗攻略",
          params: { raider_id: 6 }
        }, {
          type: "hospitals/polyclinic_charges",
        #  count: 3456,
          title: "综合医院价格攻略"
        },]
      }, { 
        type: "hospitals/tests",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_Examination.png",
        title: "全国体检",
        children: [{
          # type: "examinations/examinations",
          title: "全部体检医院",
        #  count: 3456,
          filterTitle: "体检医院",
          params: {is_exam: 1, is_service: 'f' }
        }, {
          # type: "examinations/medical_institutions",
          title: "体检机构",
        #  count: 3456,
          params: { special: 3, is_service: 'f' }
        }, {
          type: "raiders/raider_details",
          title: "体检套餐攻略",
          params: { raider_id: 3 }
        }, {
          type: "examinations/examinations",
          title: "体检价格攻略"
        }, {
          title: "热门体检",
          params: { examination_type: 1 }
        }, {
          title: "商务体检套餐",
          params: { examination_type: 74 }
        }, {
          title: "肿瘤检测",
          params: { examination_type: 65 }
        }, {
          title: "高发疾病检测",
          params: { examination_type: 93 }
        }, {
          title: "适用人群套餐",
          params: { examination_type: 22 }
        }]
      }, {
        type: "hospitals/plastics",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_Shaping.png",
        title: "整形医院",
        children: [{
          title: "全部整形医院",
          filterTitle: "整形医院",
          params: { is_service: 'f' }
        }, {
          title: "专科医院",
          params: { special: 2, is_service: 'f'}
        }, {
          type: "raiders/raider_details",
          title: "整形美容诊疗攻略",
          params: { raider_id: 8 }
        }, {
          type: "hospitals/hospital_charges",
          title: "整形美容价格攻略",
          params: { hospital_parent_type: 2 }
        }, {
          title: "眼部整形",
          params: { only_onsales: 58 }
        }, {
          title: "鼻部整形",
          params: { only_onsales: 59 }
        }, {
          title: "耳部整形",
          params: { only_onsales: 0}
        }, {
          title: "口腔整形",
          params: { only_onsales: 60 }
        }, {
          title: "激光美容",
          params: { only_onsales: 60 }
        }, {
          title: "激光脱毛",
          params: { only_onsales: 60 }
        }, {
          title: "祛斑除痣",
          params: { only_onsales: 60 }
        }, {
          title: "生殖整形",
          params: { only_onsales: 60 }
        },{
          title: "注射美容",
          params: { only_onsales: 60 }
        },{
          title: "胸部整形",
          params: { only_onsales: 61 }
        }, {
          title: "抽脂减肥",
          params: { only_onsales: 62 }
        }, {
          title: "毛发移植",
          params: { only_onsales: 63 }
        }, {
          title: "拉皮",
          params: { only_onsales: 64 }
        }, {
          title: "脂肪移植",
          params: { only_onsales: 65 }
        }, {
          title: "颌面整形",
          params: { only_onsales: 66 }
        }, {
          title: "肉毒素",
          params: { only_onsales: 67 }
        }, {
          title: "填充",
          params: { only_onsales: 68 }
        }, {
          title: "其它",
          params: { only_onsales: 69 }
        }, {
          title: "皮肤",
          params: { only_onsales: 70 }
        }, {
          title: "半永久性化妆",
          params: { only_onsales: 71 }
        }, {
          title: "疤痕修复",
          params: { only_onsales: 71 }
        }]
      }, {
        type: "hospitals/dentals",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_teeth.png",
        title: "牙科医院",
        children: [{
          title: "全部牙科医院",
          filterTitle: "牙科医院",
          params: { is_service: 'f' }
        }, {
          title: "专科医院",
          params: { special: 6, is_service: 'f'}
        }, {
          type: "raiders/raider_details",
          title: "牙科诊疗攻略",
          params: { raider_id: 5 }
        }, {
          type: "hospitals/hospital_charges",
          title: "牙科价格攻略",
          params: { hospital_parent_type: 6 }
        }, {
          title: "号源",
          params: { only_onsales: 26 }
        }, {
          title: "洗牙（洁牙）",
          params: { only_onsales: 27 }
        }, {
          title: "烤瓷牙",
          params: { only_onsales: 28 }
        }, {
          title: "牙齿矫正",
          params: { only_onsales: 29 }
        }, {
          title: "隐形矫正",
          params: { only_onsales: 30 }
         },{
        #   title: "牙齿美白",
        #   params: { hospital_type: 31 }
        # }, {
          title: "拔牙",
          params: { only_onsales: 32 }
        }, {
          title: "根管治疗",
          params: { only_onsales: 33 }
        },{
          title: "活动义齿",
          params: { only_onsales: 33 }
        }, {
          title: "全口义齿",
          params: { only_onsales: 34 }
        }, {
          title: "X光",
          params: { only_onsales: 50 }
        },{
          title: "拔除术",
          params: {}
        }, {
          title: "保持器",
          params: {}
        }, {
          title: "补牙",
          params: { only_onsales: 36 }
        }, {
          title: "矫正器",
          params: { only_onsales: 36 }
        }, {
        #   title: "牙基",
        #   params: { hospital_type: 37 }
        # }, {
          title: "精密附件",
          params: { only_onsales: 38 }
        }, {
          title: "麻醉",
          params: { only_onsales: 48 }
        }, {
          title: "排牙",
          params: { only_onsales: 44 }
        }, {
          title: "其他牙科手术",
          params: { only_onsales: 46 }
        }, {
          title: "嵌体",
          params: { only_onsales: 42 }
        }, {
          title: "上药",
          params: { only_onsales: 47 }
        }, {
          title: "牙齿美白",
          params: { only_onsales: 0 }
        }, {
          title: "牙齿漂白",
          params: { only_onsales: 39 }
        }, {
          title: "牙冠",
          params: { only_onsales: 45 }
        }, {
          title: "牙基托",
          params: { only_onsales: 45 }
        }, {
          title: "牙修复材料",
          params: { only_onsales: 41 }
        }, {
          title: "隐形矫正",
          params: { only_onsales: 0 }
        },{
          title: "种植体",
          params: { only_onsales: 0 }
        # }, {
        #   title: "种植",
        #   params: { hospital_type: 40 }
        # }, {
        #   title: "矫正",
        #   params: { hospital_type: 43 }
        # }, {
        #   title: "拔除",
        #   params: { hospital_type: 49 }
        # }, {
        #   title: "口腔检查",
        #   params: { hospital_type: 51 }
        # }, {
        #   title: "口腔设计",
        #   params: { hospital_type: 52 }
        # }, {
        #   title: "瓷贴",
        #   params: { hospital_type: 53 }
        # }, {
        #   title: "儿童口腔",
        #   params: { hospital_type: 54 }
        }]
      }, {
        type: "hospitals/gynaecologies",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_woman.png",
        title: "妇幼医院",
        children: [{
          title: "全部妇幼医院",
          filterTitle: "妇幼医院",
          params: { is_service: 'f' }
        }, {
          title: "专科医院",
          params: { special: 5, is_service: 'f'}
        }, { 
          type: "raiders/raider_details",
          title: "妇科诊疗攻略",
          params: { raider_id: 2 }
        }, { 
          type: "hospitals/hospital_charges",
          title: "妇科价格攻略",
          params: { hospital_parent_type: 5 }
        }, {
          title: "B超",
          params: { only_onsales: 82 }
        }, {
          title: "分泌物检验",
          params: { only_onsales: 83 }
        }, {
          title: "尿液检验",
          params: { only_onsales: 84 }
        }, {
          title: "通用检查",
          params: { only_onsales: 85 }
        }, {
          title: "血液检查",
          params: { only_onsales: 86 }
        }, {
          title: "阴道镜检查",
          params: { only_onsales: 87 }
        }, {
          title: "孕期检查",
          params: { only_onsales: 78 }
        }, { 
          title: "无痛人流",
          params: { only_onsales: 11 }
        }, {
          title: "四维／三维",
          params: { only_onsales: 9 }
        }, { 
          title: "妇科整形",
          params: { only_onsales: 10 }
        }, {
          title: "不孕不育",
          params: { only_onsales: 12 }
        }, {
          title: "妇科微创",
          params: { only_onsales: 80 }
        }, {
          title: "宫颈疾病手术",
          params: { only_onsales: 9 }
        }, {
          title: "痛经中心",
          params: { only_onsales: 81 }
        }, { 
        #   title: "女性不孕检查",
        #   params: { hospital_type: 12 }
        # }, { 
          title: "妇科常规检查",
          params: { only_onsales: 13 }
        }, { 
          title: "妇科常规治疗",
          params: { only_onsales: 14 }
        }, { 
          title: "产科",
          params: { only_onsales: 15 }
        }]
      }, {
        type: "hospitals/andrologies",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_man.png",
        title: "男科医院",
        children: [{
          title: "全部男科医院",
          filterTitle: "男科医院",
          params: { is_service: 'f' }
        }, {
          title: "专科医院",
          params: { special: 1, is_service: 'f'}
        }, {
          type: "raiders/raider_details",
          title: "男科诊疗攻略",
          params: { raider_id: 1 }
        }, {
          type: "hospitals/hospital_charges",
          title: "男科价格攻略",
          params: { hospital_parent_type: 1 }
        }, {
          title: "前列腺活检及治疗",
          params: { hospital_type: 16 }
        }, {
          title: "前列腺癌根治术",
          params: { hospital_type: 17 }
        }, {
          title: "男性生殖器常见手术",
          params: { hospital_type: 18 }
        }, {
          title: "检查、治疗睾丸疾病",
          params: { hospital_type: 19 }
        }, {
          title: "精索静脉曲张手术",
          params: { hospital_type: 20 }
        }, {
          title: "隐睾治疗",
          params: { hospital_type: 21 }
        }, {
          title: "男科整形",
          params: { hospital_type: 22 }
        }, {
          title: "包皮手术",
          params: { hospital_type: 23 }
        # }, {
        #   title: "男科检查",
        #   params: { hospital_type: 24 }
        # }, {
        #   title: "性功能治疗",
        #   params: { hospital_type: 25 }
        }]
      }, {
        type: "hospitals/tcm",
        image_url: "http://syso.qiniudn.com/icon%2Fnavicon_TCM.png",
        title: "中医院",
        children: [{
          title: "全部中医院",
          filterTitle: "中医院",
          params: {is_service: 'f'}
        }, {
          title: "专科医院",
          params: { special: 4, is_service: 'f'}
        }, {
          type: "raiders/raider_details",
          title: "中医诊疗攻略",
          params: { railder_id: 4}
        }, {
          type: "hospitals/hospital_charges",
          title: "中医价格攻略",
          params: { hospital_parent_type: 4 }
        }, {
          title: "中医推拿治疗",
          params: { only_onsales: 55, is_hall: 't' }
        }, {
          title: "中医针灸治疗",
          params: { only_onsales: 56, is_hall: 't' }
        }, {
          title: "其它",
          params: { only_onsales: 57, is_hall: 't' }
        }, {
          title: "针灸",
          params: { only_onsales: 0, is_hall: 't' }
        }, {
          title: "针刺",
          params: { only_onsales: 73, is_hall: 't' }
        }, {
          title: "中医肛肠",
          params: { hospital_type: 74, is_hall: 't' }
        }, {
          title: "中医骨伤",
          params: { hospital_type: 74, is_hall: 't' }
        }, {
          title: "中医特殊疗法",
          params: { hospital_type: 76, is_hall: 't' }
        }, {
          title: "中医外治",
          params: { hospital_type: 77, is_hall: 't' }
        }]
      }]
    }, {
      type: "diseases/diseases",
    #  count: Diseases::Diseas#e.count,
      title: "疾病查询",
      children: [{
        # id: :disease,
        title: "症状查疾病",
        params: { search_by: :symptom }
      }, {
        title: "科室查疾病",
        params: { search_by: :hospital_room },

      }, {
        title: "字母查疾病",
        params: { search_by: :alphabet }
      }, {
        title: "常见病查疾病",
        # params: { search_by: :common_disease }
        children: Diseases::CommonDisease.all.map do |common_disease|
            {
            title: common_disease.name, 
            # id: common_disease.id,
            params: {
              search_by: :common_disease,
              common_disease: common_disease.id,
              # type: 134
            }
          }
          end
      }, {
        title: "病理查疾病",
        # params: { search_by: :disease_type }
        children: Diseases::DiseaseType.all.map do |disease_type|
          {
            title: disease_type.name,
            # id: disease_type.id,
            params: {
              search_by: :disease_type,
              disease_type: disease_type.id,
              # type: 135
            }
          }
        end
      }]
    }, {
      type: "hospitals/characteristics",
      title: "特色科室",
    #  count: Hospitals::CharacteristicHospita#l.count,
      children: Hospitals::Characteristic.all.map do |characteristic|
          {
            title: characteristic.name,
            # id: characteristic.id,
          #  count: characteristic.hospita#l_count,
            params: {
              search_by: :characteristic,
              characteristic_hospitals: characteristic.id,
            }
          }
        end
      },{
      type: "hospitals/doctors",
      title: "找医生",
    #  count: Hospitals::Docto#r.count,
      children: [{
        type: "hospitals/all",
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
        type: "favorites",
        title: "找专家医生攻略"
      }]
    }, {
      type: "drugs/drugs",
      title: "药品大全",
    #  count: Drugs::Dru#g.count,
      children: [{
        id: :drug,
        title: "疾病查药品",
        params: { search_by: :disease }
      }, {
      #   title: "科室查药品",
      #   params: { search_by: :hospital_room }
      # }, {
        title: "字母查药品",
        params: { search_by: :alphabet }
      }, {
        type: "drugs/manufactories",
        title: "药企查药品",
        children: ('a'..'z').to_a.map(&:upcase).map {|alph| {:title => alph, :id => alph, :params => {:alphabet => alph }}}
        # params: { search_by: :manufactory }
      }, {
        type: "social_securities/social_securities",
        title: "医保定点药品",
        params: { social_security_type: 3 }
      }, {
        type: "drugs/drug_manufactory_stores",
        title: "团购药品",
        # params: { social_security_type: 3 }
      }]
    }, {
      type: "drugs/drugstores",
    #  count: Drugs::Drugstor#e.count,
      title: "身边药房",
      children: [{
        id: :drugstore,
        title: "字母找药店",
        params: { search_by: :alphabet },
        children: ('a'..'z').to_a.map(&:upcase).map {|alph| {:title => alph, :id => alph, :params => {:alphabet => alph }}}
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
    #  count: SocialSecurities::SocialSecurit#y.count,
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
        type: "insurances/insurances",
        title: "健康险攻略"
      }]
    }, {
      title: "诊疗攻略",
      children: [{
        id: :price_search,
        url:  "#/list/hospitals/polyclinic_charges?type=price_search",
        type: "hospitals/polyclinic_charges",
        title: "综合医院价格攻略"
      }, {
        type: "examinations/examinations",
        title: "全国体检价格攻略"
      }, {
        # type: "hospitals/hospital_charges",
        type: "hospitals/hospital_types",
        title: "整形医院价格攻略",
        params: { hospital_parent_type: 2 }
      }, {
        # type: "hospitals/hospital_charges",
        type: "hospitals/hospital_types",
        title: "牙科医院价格攻略",
        params: { hospital_parent_type: 6 }
      }, {
        # type: "hospitals/hospital_charges",
        type: "hospitals/hospital_types",
        title: "妇幼医院价格攻略",
        params: { hospital_parent_type: 5 }
      }, {
        # type: "hospitals/hospital_charges",
        type: "hospitals/hospital_types",
        title: "男科医院价格攻略",
        params: { hospital_parent_type: 1 }
      }, {
        # type: "hospitals/hospital_charges",
        type: "hospitals/hospital_types",
        title: "中医院价格攻略",
        params: { hospital_parent_type: 4 }
      }, {
        type: "drugs/drugs",
        title: "药品价格查询"
      }, {
        type: "insurances/insurances",
        title: "健康保险价格查询"
      }, {
        type: "insurances/insurances",
        title: "养老保险价格查询"
      }, {
        type: "maternals/confinement_centers",
        title: "月子中心价格查询"
      }, {
        title: "返利优惠"
      }, {
        title: "代金券"
      }]
    }, {
      type: "examinations/examinations",
      title: "全国体检",
    #  count: Examinations::Examinatio#n.count,
      children: [{
        id: :examination,
        title: "全部",
        filterTitle: "全国体检"
      }, {
        title: "热门体检",
        children: Examinations::ExaminationType.where(parent_id: 1).map do |type|
          {
            title: type.name,
            params: { examination_type_id: type.id }
          }
        end
        #params: { examination_parent_type: 1 }
      }, {
        title: "体检机构",
        params: { examination_parent_type: 1 }
      }, {
        title: "商务体检套餐",
        children: Examinations::ExaminationType.where(parent_id: 74).map do |type|
          {
            title: type.name,
            params: { examination_type_id: type.id }
          }
        end
        # params: { examination_parent_type: 74 }
      }, {
        title: "肿瘤检测",
        children: Examinations::ExaminationType.where(parent_id: 65).map do |type|
          {
            title: type.name,
            params: { examination_type_id: type.id }
          } 
        end
        # params: { examination_parent_type: 65 }
      }, {
        title: "高发疾病检测",
        children: Examinations::ExaminationType.where(parent_id: 93).map do |type|
          {
            title: type.name,
            params: { examination_type_id: type.id }
          }
        end
        # params: { examination_parent_type: 93 }
      }, {
        title: "适用人群套餐",
        children: Examinations::ExaminationType.where(parent_id: 22).map do |type|
          {
            title: type.name,
            params: { examination_type_id: type.id }
          }
        end
        # params: { examination_parent_type: 22 }
      }, {
        type: "hospitals/hospital_news",
        title: "体检诊疗攻略",
        params: { hospital_type: 3 }
      }, {
        type: "examinations/examinations",
        title: "体检价格攻略"
      }]
    }, {
      title: "养老服务",
    #  count: Eldercares::NursingRoo#m.count+SocialSecurities::SocialSecurity.where(social_security_type_id: 5#).count+Insurances::Insuranc#e.count,
      children: [{
        id: :eldercare,
        type: :"eldercares/nursing_rooms",
      #  count: Eldercares::NursingRoo#m.count,
        title: "养老公寓"
      }, {
        type: :"social_securities/social_securities",
        title: "养老保险（社保）查询",
      #  count: SocialSecurities::SocialSecurity.where(social_security_type_id: 5#).count,
        params: { social_security_type: 5 }
      }, {
        type: :"insurances/insurances",
      #  count: Insurances::Insuranc#e.count,
        title: "养老保险（商业）攻略"
      }]
    }, {
      title: "母婴亲子",
    #  count: Maternals::ConfinementCente#r.count+Maternals::MaternalHal#l.count,
      children: [{
        id: :eldercare,
        type: "maternals/confinement_centers",
        image_url: "http://syso.qiniudn.com/iconyuezizhongxin_icon.png",
      #  count: Maternals::ConfinementCente#r.count,
        title: "月子中心"
      }, {
        type: "maternals/maternal_halls",
        image_url: "http://syso.qiniudn.com/iconyuyinghuiguan_icon.jpg",
      #  count: Maternals::MaternalHal#l.count,
        title: "母婴会馆",
        params: { social_security_type: 5 }
      }]
    }, {
      title: "最新优惠"
    #  count: Maternals::ConfinementCente#r.count+Maternals::MaternalHal#l.count,
    }]
  end

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

  # format_menu type_menu

  namespace :types do
    get :filters do
      # TypeMenu
      [{
        type: "coupons/coupons",
        title: "热门精选",
      #  count: 0
        }, {
        title: "医院大全",
        ## count: Hospitals::Hospita#l.count,
        children: [{
          # type: "hospitals/all?type=3",
          title: "全部分类"
          }, {
          type: "hospitals/polyclinics",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_Complex.png",
          title: "综合医院",
          children: [{
            id: :polyclinic,
            title: "全部医院",
            filterTitle: "综合医院"
          }, {
            title: "三级甲等",
            ## count: Hospitals::Hospital.where(hospital_level: 2, city_id: params[:city]#).count,
            params: { hospital_level: 2 }
          }, {
            title: "三级乙等",
            ## count: Hospitals::Hospital.where(hospital_level: 3, city_id: params[:city]#).count,
            params: { hospital_level: 3 }
          }, {
            title: "三级合格",
            ## count: Hospitals::Hospital.where(hospital_level: 4, city_id: params[:city]#).count,
            params: { hospital_level: 4 }
          }, {
            title: "二级甲等",
          #  count: Hospitals::Hospital.where(hospital_level: 5, city_id: params[:city]#).count,
            params: { hospital_level: 5 }
          }, {
            title: "二级乙等",
            ## count: Hospitals::Hospital.where(hospital_level: 6, city_id: params[:city]#).count,
            params: { hospital_level: 6 }
          }, {
            title: "二级合格",
            ## count: Hospitals::Hospital.where(hospital_level: 7, city_id: params[:city]#).count,
            params: { hospital_level: 7 }
          }, {
            title: "一级甲等",
            ## count: Hospitals::Hospital.where(hospital_level: 8, city_id: params[:city]#).count,
            params: { hospital_level: 8 }
          }, {
            title: "一级乙等",
          #  count: Hospitals::Hospital.where(hospital_level: 9, city_id: params[:city]#).count,
            params: { hospital_level: 9 }
          }, {
            title: "一级合格",
          #  count: Hospitals::Hospital.where(hospital_level: 10, city_id: params[:city]#).count,
            params: { hospital_level: 10 }
          }, {
            title: "外资医院",
          #  count: Hospitals::Hospital.where(is_foreign: true, city_id: params[:city]#).count,
            params: { is_foreign: true }
            
          }, {
            title: "社区医院",
          #  count: Hospitals::Hospital.where(is_community: true, city_id: params[:city]#).count,
            params: { is_community: true }
          }, {
            title: "其他医院",
          #  count: Hospitals::Hospital.where(is_other: true, city_id: params[:city]#).count,
            params: { is_other: true }
          }, {
            type: "social_securities/social_securities",
            title: "社保定点医院",
          #  count: Hospitals::Hospital.where(is_other: true, city_id: params[:city]#).count,
            params: { social_security_type: 2 }
          }, {
            type: "raiders/raider_details",
          #  count: Hospitals::Hospital.where(is_other: true, city_id: params[:city]#).count,
            title: "综合医院诊疗攻略",
            params: { raider_id: 6 }
          }, {
            type: "hospitals/polyclinic_charges",
          #  count: Hospitals::Hospital.where(is_other: true, city_id: params[:city]#).count,
            title: "综合医院价格攻略"
          },]
        }, { 
          type: "hospitals/tests",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_Examination.png",
          title: "全国体检",
          children: [{
            # type: "examinations/examinations",
            title: "全部体检医院",
          #  count: 3456,
            filterTitle: "体检医院",
            params: {is_exam: 1, is_service: 'f' }
          }, {
            # type: "examinations/medical_institutions",
            title: "体检机构",
          #  count: 3456,
            params: { special: 3, is_service: 'f' }
          }, {
            type: "raiders/raider_details",
            title: "体检套餐攻略",
            params: { raider_id: 3 }
          }, {
            type: "examinations/examinations",
            title: "体检价格攻略"
          }, {
            title: "热门体检",
            params: { examination_type: 1 }
          }, {
            title: "商务体检套餐",
            params: { examination_type: 74 }
          }, {
            title: "肿瘤检测",
            params: { examination_type: 65 }
          }, {
            title: "高发疾病检测",
            params: { examination_type: 93 }
          }, {
            title: "适用人群套餐",
            params: { examination_type: 22 }
          }]
        }, {
          type: "hospitals/plastics",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_Shaping.png",
          title: "整形医院",
          children: [{
            title: "全部整形医院",
            filterTitle: "整形医院",
            params: { is_service: 'f' }
          }, {
            title: "专科医院",
            params: { special: 2, is_service: 'f'}
          }, {
            type: "raiders/raider_details",
            title: "整形美容诊疗攻略",
            params: { raider_id: 8 }
          }, {
            type: "hospitals/hospital_charges",
            title: "整形美容价格攻略",
            params: { hospital_parent_type: 2 }
          }, {
            title: "眼部整形",
            params: { only_onsales: 58 }
          }, {
            title: "鼻部整形",
            params: { only_onsales: 59 }
          }, {
            title: "耳部整形",
            params: { only_onsales: 0}
          }, {
            title: "口腔整形",
            params: { only_onsales: 60 }
          }, {
            title: "激光美容",
            params: { only_onsales: 60 }
          }, {
            title: "激光脱毛",
            params: { only_onsales: 60 }
          }, {
            title: "祛斑除痣",
            params: { only_onsales: 60 }
          }, {
            title: "生殖整形",
            params: { only_onsales: 60 }
          },{
            title: "注射美容",
            params: { only_onsales: 60 }
          },{
            title: "胸部整形",
            params: { only_onsales: 61 }
          }, {
            title: "抽脂减肥",
            params: { only_onsales: 62 }
          }, {
            title: "毛发移植",
            params: { only_onsales: 63 }
          }, {
            title: "拉皮",
            params: { only_onsales: 64 }
          }, {
            title: "脂肪移植",
            params: { only_onsales: 65 }
          }, {
            title: "颌面整形",
            params: { only_onsales: 66 }
          }, {
            title: "肉毒素",
            params: { only_onsales: 67 }
          }, {
            title: "填充",
            params: { only_onsales: 68 }
          }, {
            title: "其它",
            params: { only_onsales: 69 }
          }, {
            title: "皮肤",
            params: { only_onsales: 70 }
          }, {
            title: "半永久性化妆",
            params: { only_onsales: 71 }
          }, {
            title: "疤痕修复",
            params: { only_onsales: 71 }
          }]
        }, {
          type: "hospitals/dentals",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_teeth.png",
          title: "牙科医院",
          children: [{
            title: "全部牙科医院",
            filterTitle: "牙科医院",
            params: { is_service: 'f' }
          }, {
            title: "专科医院",
            params: { special: 6, is_service: 'f'}
          }, {
            type: "raiders/raider_details",
            title: "牙科诊疗攻略",
            params: { raider_id: 5 }
          }, {
            type: "hospitals/hospital_charges",
            title: "牙科价格攻略",
            params: { hospital_parent_type: 6 }
          }, {
            title: "号源",
            params: { only_onsales: 26 }
          }, {
            title: "洗牙（洁牙）",
            params: { only_onsales: 27 }
          }, {
            title: "烤瓷牙",
            params: { only_onsales: 28 }
          }, {
            title: "牙齿矫正",
            params: { only_onsales: 29 }
          }, {
            title: "隐形矫正",
            params: { only_onsales: 30 }
           },{
          #   title: "牙齿美白",
          #   params: { hospital_type: 31 }
          # }, {
            title: "拔牙",
            params: { only_onsales: 32 }
          }, {
            title: "根管治疗",
            params: { only_onsales: 33 }
          },{
            title: "活动义齿",
            params: { only_onsales: 33 }
          }, {
            title: "全口义齿",
            params: { only_onsales: 34 }
          }, {
            title: "X光",
            params: { only_onsales: 50 }
          },{
            title: "拔除术",
            params: {}
          }, {
            title: "保持器",
            params: {}
          }, {
            title: "补牙",
            params: { only_onsales: 36 }
          }, {
            title: "矫正器",
            params: { only_onsales: 36 }
          }, {
          #   title: "牙基",
          #   params: { hospital_type: 37 }
          # }, {
            title: "精密附件",
            params: { only_onsales: 38 }
          }, {
            title: "麻醉",
            params: { only_onsales: 48 }
          }, {
            title: "排牙",
            params: { only_onsales: 44 }
          }, {
            title: "其他牙科手术",
            params: { only_onsales: 46 }
          }, {
            title: "嵌体",
            params: { only_onsales: 42 }
          }, {
            title: "上药",
            params: { only_onsales: 47 }
          }, {
            title: "牙齿美白",
            params: { only_onsales: 0 }
          }, {
            title: "牙齿漂白",
            params: { only_onsales: 39 }
          }, {
            title: "牙冠",
            params: { only_onsales: 45 }
          }, {
            title: "牙基托",
            params: { only_onsales: 45 }
          }, {
            title: "牙修复材料",
            params: { only_onsales: 41 }
          }, {
            title: "隐形矫正",
            params: { only_onsales: 0 }
          },{
            title: "种植体",
            params: { only_onsales: 0 }
          # }, {
          #   title: "种植",
          #   params: { hospital_type: 40 }
          # }, {
          #   title: "矫正",
          #   params: { hospital_type: 43 }
          # }, {
          #   title: "拔除",
          #   params: { hospital_type: 49 }
          # }, {
          #   title: "口腔检查",
          #   params: { hospital_type: 51 }
          # }, {
          #   title: "口腔设计",
          #   params: { hospital_type: 52 }
          # }, {
          #   title: "瓷贴",
          #   params: { hospital_type: 53 }
          # }, {
          #   title: "儿童口腔",
          #   params: { hospital_type: 54 }
          }]
        }, {
          type: "hospitals/gynaecologies",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_woman.png",
          title: "妇幼医院",
          children: [{
            title: "全部妇幼医院",
            filterTitle: "妇幼医院",
            params: { is_service: 'f' }
          }, {
            title: "专科医院",
            params: { special: 5, is_service: 'f'}
          }, { 
            type: "raiders/raider_details",
            title: "妇科诊疗攻略",
            params: { raider_id: 2 }
          }, { 
            type: "hospitals/hospital_charges",
            title: "妇科价格攻略",
            params: { hospital_parent_type: 5 }
          }, {
            title: "B超",
            params: { only_onsales: 82 }
          }, {
            title: "分泌物检验",
            params: { only_onsales: 83 }
          }, {
            title: "尿液检验",
            params: { only_onsales: 84 }
          }, {
            title: "通用检查",
            params: { only_onsales: 85 }
          }, {
            title: "血液检查",
            params: { only_onsales: 86 }
          }, {
            title: "阴道镜检查",
            params: { only_onsales: 87 }
          }, {
            title: "孕期检查",
            params: { only_onsales: 78 }
          }, { 
            title: "无痛人流",
            params: { only_onsales: 11 }
          }, {
            title: "四维／三维",
            params: { only_onsales: 9 }
          }, { 
            title: "妇科整形",
            params: { only_onsales: 10 }
          }, {
            title: "不孕不育",
            params: { only_onsales: 12 }
          }, {
            title: "妇科微创",
            params: { only_onsales: 80 }
          }, {
            title: "宫颈疾病手术",
            params: { only_onsales: 9 }
          }, {
            title: "痛经中心",
            params: { only_onsales: 81 }
          }, { 
          #   title: "女性不孕检查",
          #   params: { hospital_type: 12 }
          # }, { 
            title: "妇科常规检查",
            params: { only_onsales: 13 }
          }, { 
            title: "妇科常规治疗",
            params: { only_onsales: 14 }
          }, { 
            title: "产科",
            params: { only_onsales: 15 }
          }]
        }, {
          type: "hospitals/andrologies",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_man.png",
          title: "男科医院",
          children: [{
            title: "全部男科医院",
            filterTitle: "男科医院",
            params: { is_service: 'f' }
          }, {
            title: "专科医院",
            params: { special: 1, is_service: 'f'}
          }, {
            type: "raiders/raider_details",
            title: "男科诊疗攻略",
            params: { raider_id: 1 }
          }, {
            type: "hospitals/hospital_charges",
            title: "男科价格攻略",
            params: { hospital_parent_type: 1 }
          }, {
            title: "前列腺活检及治疗",
            params: { only_onsales: 16 }
          }, {
            title: "前列腺癌根治术",
            params: { only_onsales: 17 }
          }, {
            title: "男性生殖器常见手术",
            params: { only_onsales: 18 }
          }, {
            title: "检查、治疗睾丸疾病",
            params: { only_onsales: 19 }
          }, {
            title: "精索静脉曲张手术",
            params: { only_onsales: 20 }
          }, {
            title: "隐睾治疗",
            params: { only_onsales: 21 }
          }, {
            title: "男科整形",
            params: { hospital_type: 22 }
          }, {
            title: "包皮手术",
            params: { hospital_type: 23 }
          # }, {
          #   title: "男科检查",
          #   params: { hospital_type: 24 }
          # }, {
          #   title: "性功能治疗",
          #   params: { hospital_type: 25 }
          }]
        }, {
          type: "hospitals/tcm",
          image_url: "http://syso.qiniudn.com/icon%2Fnavicon_TCM.png",
          title: "中医院",
          children: [{
            title: "全部中医院",
            filterTitle: "中医院",
            params: {is_service: 'f'}
          }, {
            title: "专科医院",
            params: { special: 4, is_service: 'f'}
          }, {
            type: "raiders/raider_details",
            title: "中医诊疗攻略",
            params: { railder_id: 4}
          }, {
            type: "hospitals/hospital_charges",
            title: "中医价格攻略",
            params: { hospital_parent_type: 4 }
          }, {
            title: "中医推拿治疗",
            params: { only_onsales: 55, is_hall: 't' }
          }, {
            title: "中医针灸治疗",
            params: { only_onsales: 56, is_hall: 't' }
          }, {
            title: "其它",
            params: { only_onsales: 57, is_hall: 't'  }
          }, {
            title: "针灸",
            params: { only_onsales: 0, is_hall: 't'  }
          }, {
            title: "针刺",
            params: { only_onsales: 73, is_hall: 't'  }
          }, {
            title: "中医肛肠",
            params: { only_onsales: 74, is_hall: 't'  }
          }, {
            title: "中医骨伤",
            params: { only_onsales: 74, is_hall: 't'  }
          }, {
            title: "中医特殊疗法",
            params: { hospital_type: 76, is_hall: 't'  }
          }, {
            title: "中医外治",
            params: { hospital_type: 77 }
          }]
        }]
      }, {
        type: "diseases/diseases",
      #  count: Diseases::Diseas#e.count,
        title: "疾病查询",
        children: [{
          # id: :disease,
          title: "症状查疾病",
          params: { search_by: :symptom }
        }, {
          title: "科室查疾病",
          # params: { search_by: :hospital_room }
          children: Hospitals::HospitalRoom.where("parent_id is NULL").map do |hospital_room| 
            {
              title: hospital_room.name,
              params: {
                search_by: :hospital_room,
                hospital_room: hospital_room.id
              }
            }
          end
        }, {
          title: "字母查疾病",
          params: { search_by: :alphabet }
        }, {
          title: "常见病查疾病",
          # params: { search_by: :common_disease }
          children: Diseases::CommonDisease.all.map do |common_disease|
              {
              title: common_disease.name, 
              # id: common_disease.id,
              params: {
                search_by: :common_disease,
                common_disease: common_disease.id,
                # type: 134
              }
            }
            end
        # }, {
        #   title: "病理查疾病",
        #   # params: { search_by: :disease_type }
        #   children: Diseases::DiseaseType.all.map do |disease_type|
        #     {
        #       title: disease_type.name,
        #       # id: disease_type.id,
        #       params: {
        #         search_by: :disease_type,
        #         disease_type: disease_type.id,
        #         # type: 135
        #       }
        #     }
        #   end
        }]
      }, {
        type: "hospitals/characteristics",
        title: "特色科室",
      #  count: Hospitals::CharacteristicHospita#l.count,
        children: Hospitals::Characteristic.all.map do |characteristic|
            {
              title: characteristic.name,
              # id: characteristic.id,
            #  count: characteristic.hospita#l_count,
              params: {
                search_by: :characteristic,
                characteristic_hospitals: characteristic.id,
              }
            }
          end
        },{
        type: "hospitals/doctors",
        title: "找医生",
      #  count: Hospitals::Doctor.count,
        children: [{
          type: "hospitals/all",
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
          type: "favorites",
          title: "找专家医生攻略"
        }]
      }, {
        type: "drugs/drugs",
        title: "药品大全",
      #  count: Drugs::Dru#g.count,
        children: [{
          id: :drug,
          title: "疾病查药品",
          params: { search_by: :disease }
        }, {
        #   title: "科室查药品",
        #   params: { search_by: :hospital_room }
        # }, {
          title: "字母查药品",
          params: { search_by: :alphabet }
        }, {
          # type: "drugs/manufactories",
          type: "drugs/drugs",
          title: "药企查药品",
          children: ('a'..'z').to_a.map(&:upcase).map {|alph| {:title => alph, :id => alph, :params => {:manufactory_alph => alph, search_by: :manufactory_alph}}}
          # params: { search_by: :manufactory }
        }, {
          type: "social_securities/social_securities",
          title: "医保定点药品",
          params: { social_security_type: 3 }
        }, {
          type: "drugs/drug_manufactory_stores",
          title: "团购药品",
          # params: { social_security_type: 3 }
        }]
      }, {
        type: "drugs/drugstores",
      #  count: Drugs::Drugstor#e.count,
        title: "身边药房",
        children: [{
          id: :drugstore,
          title: "字母找药店",
          params: { search_by: :alphabet },
          children: ('a'..'z').to_a.map(&:upcase).map {|alph| {:title => alph, :id => alph, :params => {:alphabet => alph }}}
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
      #  count: SocialSecurities::SocialSecurit#y.count,
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
          type: "insurances/insurances",
          title: "健康险攻略"
        }]
      }, {
        title: "诊疗攻略",
        children: [{
          id: :price_search,
          url:  "#/list/hospitals/polyclinic_charges?type=price_search",
          type: "hospitals/polyclinic_charges",
          title: "综合医院价格攻略"
        }, {
          type: "examinations/examinations",
          title: "全国体检价格攻略"
        }, {
          # type: "hospitals/hospital_charges",
          type: "hospitals/hospital_types",
          title: "整形医院价格攻略",
          params: { hospital_parent_type: 2 }
        }, {
          # type: "hospitals/hospital_charges",
          type: "hospitals/hospital_types",
          title: "牙科医院价格攻略",
          params: { hospital_parent_type: 6 }
        }, {
          # type: "hospitals/hospital_charges",
          type: "hospitals/hospital_types",
          title: "妇幼医院价格攻略",
          params: { hospital_parent_type: 5 }
        }, {
          # type: "hospitals/hospital_charges",
          type: "hospitals/hospital_types",
          title: "男科医院价格攻略",
          params: { hospital_parent_type: 1 }
        }, {
          # type: "hospitals/hospital_charges",
          type: "hospitals/hospital_types",
          title: "中医院价格攻略",
          params: { hospital_parent_type: 4 }
        }, {
          type: "drugs/drugs",
          title: "药品价格查询"
        }, {
          type: "insurances/insurances",
          title: "健康保险价格查询"
        }, {
          type: "insurances/insurances",
          title: "养老保险价格查询"
        }, {
          type: "maternals/confinement_centers",
          title: "月子中心价格查询"
        }, {
          title: "返利优惠"
        }, {
          title: "代金券"
        }]
      }, {
        type: "examinations/examinations",
        title: "全国体检",
      #  count: Examinations::Examinatio#n.count,
        children: [{
          id: :examination,
          title: "全部",
          filterTitle: "全国体检"
        }, {
          title: "热门体检",
          children: Examinations::ExaminationType.where(parent_id: 1).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          #params: { examination_parent_type: 1 }
        }, {
          title: "体检机构",
          params: { examination_parent_type: 1 }
        }, {
          title: "商务体检套餐",
          children: Examinations::ExaminationType.where(parent_id: 74).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          # params: { examination_parent_type: 74 }
        }, {
          title: "肿瘤检测",
          children: Examinations::ExaminationType.where(parent_id: 65).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            } 
          end
          # params: { examination_parent_type: 65 }
        }, {
          title: "高发疾病检测",
          children: Examinations::ExaminationType.where(parent_id: 93).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          # params: { examination_parent_type: 93 }
        }, {
          title: "适用人群套餐",
          children: Examinations::ExaminationType.where(parent_id: 22).map do |type|
            {
              title: type.name,
              params: { examination_type_id: type.id }
            }
          end
          # params: { examination_parent_type: 22 }
        }, {
          type: "hospitals/hospital_news",
          title: "体检诊疗攻略",
          params: { hospital_type: 3 }
        }, {
          type: "examinations/examinations",
          title: "体检价格攻略"
        }]
      }, {
        title: "养老服务",
      #  count: Eldercares::NursingRoom.count+SocialSecurities::SocialSecurity.where(social_security_type_id: 5#).count+Insurances::Insuranc#e.count,
        children: [{
          id: :eldercare,
          type: :"eldercares/nursing_rooms",
        #  count: Eldercares::NursingRoom.count,
          title: "养老公寓"
        }, {
          type: :"social_securities/social_securities",
          title: "养老保险（社保）查询",
        #  count: SocialSecurities::SocialSecurity.where(social_security_type_id: 5#).count,
          params: { social_security_type: 5 }
        }, {
          type: :"insurances/insurances",
        #  count: Insurances::Insurance.count,
          title: "养老保险（商业）攻略"
        }]
      }, {
        title: "团购优惠",
        children: Hospitals::HospitalType.where(parent_id: [nil, '']).map do |hospital_type|
          {
            title: hospital_type.name,
            params: {
              hospital_type: hospital_type.id
            }
          }
        end
      }, {
        title: "母婴亲子",
      #  count: Maternals::ConfinementCente#r.count+Maternals::MaternalHal#l.count,
        children: [{
          id: :eldercare,
          type: "privileges/maternals/confinement_centers",
          image_url: "http://syso.qiniudn.com/iconyuezizhongxin_icon.png",
        #  count: Maternals::ConfinementCente#r.count,
          title: "月子中心"
        }, {
          type: "privileges/maternals/maternal_halls",
          image_url: "http://syso.qiniudn.com/iconyuyinghuiguan_icon.jpg",
        #  count: Maternals::MaternalHal#l.count,
          title: "母婴会馆",
          params: { social_security_type: 5 }
        }]
      }]
      end
  end

end