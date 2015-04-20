class Raiders::RaiderDetailsAPI < ApplicationAPI

  namespace :raider_details do
    index! Raiders::RaiderDetail,
      title: proc { Raiders::Raider.where(id: params[:raider_id]).first.name},
      related: true,
      filters: { 
        # city: city_filters,
        type: type_filters(proc { Raiders::Raider.where(id: params[:raider_id]).first.name}),
        # hospital_type: { scope_only: true, default: 1 },
        # order_by_url: { scope_only: true, default: 1 },
        county: county_filters,
        raider_id: { scope_only: true },
        # order_by: hospital_order_by_filters,
        # form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters,
        # hospital_level: form_radio_filters(Hospitals::HospitalLevel, "医院等级"),
        # has_url: form_switch_filters("网址"),
        # is_local_hot: form_switch_filters("热门医院")
        # need_order: form_switch_filters("无需预约"),
        # has_return: form_switch_filters("返现"),
        # template: form_radio_array_filters(%w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术),
          # "当前主题精选"),
        # template: form_radio_array_filters_new("andrology", "当前主题精选"),
        # price_scope: form_price_scope_filters([500, 1000, 5000, 10000, 20000])
      }

    params do
      requires :id, type: Integer
    end
    get ":id" do
      present! Raiders::RaiderDetail.find(params[:id])
    end
  end
end
