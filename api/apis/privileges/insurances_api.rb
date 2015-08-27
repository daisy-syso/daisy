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
        # template: form_radio_array_filters(%w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术),
          # "当前主题精选"),
        template: form_radio_array_filters_new("andrology", "当前主题精选"),
        price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      }
    show! Insurances::CommercialInsurance
	end

end