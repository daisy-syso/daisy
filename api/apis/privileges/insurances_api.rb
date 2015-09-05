class Privileges::InsurancesAPI < ApplicationAPI

	namespace :insurances do 

		index! Insurances::CommercialInsurance,
			title: "疾病保险",
      filters: { 
        type: type_filters("疾病保险"),
        classification: classification_filters,
        order_by: hospital_order_by_filters,
        form: form_filters,
        # extension: { scope_only: true, default: 1, type: Integer},
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 低价保障型 转保癌症 住院费用报 长期保障型 终身保险 电话医生服务 满期返还型 保意外伤害 女性疾病保障 特定疾病保障 少儿专款),
          "当前主题精选"),
      }
    show! Insurances::CommercialInsurance
	end

end