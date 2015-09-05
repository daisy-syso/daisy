class Eldercares::EldercaresAPI < ApplicationAPI

  namespace :nursing_rooms do
    index! Eldercares::NursingRoom,
      title: "养老精选",
      filters: { 
        city: city_filters,
        type: type_filters("养老精选"),
        county: county_filters,
        null_last: { scope_only: true, default: 1 },
        order_by: order_by_filters(Eldercares::NursingRoom),
        form: form_filters,
        query: form_query_filters, 
        appointment: form_switch_filters("无需预约"),
        has_return: form_switch_filters("优惠返利"),
        theme: form_radio_array_filters(%w(不限 养老院 福利院 疗养院 老年公寓 其它), "当前主题精选"),
        price_type:form_radio_array_filters(%w(不限 500元以下 500-1000元 1000-3000元 3000-5000元 5000元以上), "价格排列按钮")
      }

    show! Eldercares::NursingRoom
  end
end
