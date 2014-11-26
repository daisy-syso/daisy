class Hospitals::HospitalsAPI < ApplicationAPI

  namespace :hospitals do
    # index! Hospitals::Hospital,
    #   title: "医院大全",
    #   filters: { 
    #     city: city_filters,
    #     type: type_filters(:hospital),
    #     hospital_type: { scope_only: true },
    #     county: county_filters,
    #     order_by: hospital_order_by_filters,
    #     form: form_filters,
    #     query: form_query_filters, 
    #     alphabet: form_alphabet_filters,
    #     hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
    #     has_url: form_switch_filters("网址"),
    #     is_local_hot: form_switch_filters("热门医院")
    #   }

    get ":id" do
      hospital = Hospitals::Hospital.find params[:id]
      present! hospital, detail: true
      hospital.click!
    end
  end

  # namespace :registrations do
  #   index! Hospitals::Hospital,
  #     title: "手机挂号",
  #     filters: { 
  #       city: city_filters,
  #       type: type_filters(:hospital),
  #       hospital_type: { scope_only: true },
  #       county: county_filters,
  #       order_by: hospital_order_by_filters,
  #       form: form_filters,
  #       query: form_query_filters, 
  #       alphabet: form_alphabet_filters,
  #       hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
  #       has_url: form_switch_filters("网址"),
  #       is_local_hot: form_switch_filters("热门医院")
  #     }
  # end

  namespace :andrologies do
    index! Hospitals::Hospital,
      title: "男科医院",
      filters: { 
        city: city_filters,
        type: type_filters,
        hospital_type: { scope_only: true, default: 1 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术),
          "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      }
  end

  namespace :plastics do
    index! Hospitals::Hospital,
      title: "整形医院",
      filters: { 
        city: city_filters,
        type: type_filters,
        hospital_type: { scope_only: true, default: 2 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 双眼皮（埋线法） 双眼皮（切开法） 内眼角 外眼角 上眼皮下垂 上下眼睑 眼睫毛皮肤切除 眼睫毛植毛 祛眼袋 内眦成形术 ),
          "当前主题精选"),
        price_scope: form_price_scope_filters([1000, 3000, 5000, 10000, 50000])
      }
  end

  namespace :tests do
    index! Hospitals::Hospital,
      title: "体检医院",
      filters: { 
        city: city_filters,
        type: type_filters,
        examination_type: { scope_only: true },
        hospital_type: { scope_only: true, default: 3 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 基础体检 单位团体体检 常规体检 婚前体检 孕前体检 儿童体检 老年体检 妇科体检 青年体检 精英体检 高端体检),
          "当前主题精选"),
        price_scope: form_price_scope_filters([300, 600, 1000, 2000, 4000])
      }
  end

  namespace :tcm do
    index! Hospitals::Hospital,
      title: "中医院",
      filters: { 
        city: city_filters,
        type: type_filters,
        hospital_type: { scope_only: true, default: 4 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 颈椎病推拿治疗 寰枢关节失稳推拿治疗 颈椎小关节紊乱推拿治疗 胸椎小关节紊乱推拿治疗 腰椎小关节紊乱推拿治疗 腰椎间盘突出推拿治疗 第三腰椎横突综合征推拿治疗 骶髂关节紊乱症推拿治疗 强直性脊柱炎推拿治疗 外伤性截瘫推拿治疗 退行性脊柱炎推拿治疗 ),
          "当前主题精选"),
        price_scope: form_price_scope_filters([10, 50, 100])
      }
  end

  namespace :gynaecologies do
    index! Hospitals::Hospital,
      title: "妇幼医院",
      filters: { 
        city: city_filters,
        type: type_filters,
        hospital_type: { scope_only: true, default: 5 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 剖腹产 卵巢囊切除术 子宫全切 子宫次全切 取环 放环 清宫 无痛清宫 引产术 子宫肌瘤剜除), 
          "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000])
      }
  end

  namespace :dentals do
    index! Hospitals::Hospital,
      title: "牙科医院",
      filters: { 
        city: city_filters,
        type: type_filters,
        hospital_type: { scope_only: true, default: 6 },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 全瓷牙 镍铬烤瓷牙 钴铬合金烤瓷牙 钯银合金烤瓷牙 钯金合金烤瓷牙 钛合金烤瓷牙 E.MAX全瓷牙 美国"雷诺皓瓷牙"瑞典Procera皓瓷牙 德国泽康皓瓷牙),
          "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      }
  end

  namespace :polyclinics do
    index! Hospitals::Hospital,
      title: "综合医院",
      filters: { 
        city: city_filters,
        type: type_filters(:polyclinic),
        hospital_type: { scope_only: true, default: 7 },
        hospital_level: { scope_only: true },
        county: county_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # query: form_query_filters, 
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院"),
        is_foreign: { scope_only: true, type: Object },
        is_other: { scope_only: true, type: Object },
        is_community: { scope_only: true, type: Object },
        has_mobile_url: form_switch_filters("手机挂号"),
        has_return: form_switch_filters("优惠返利"),
        template: form_radio_array_filters(%w(不限 热门医院 有网址),
          "当前主题精选"),
        alphabet: form_alphabet_filters
      }
  end
end
