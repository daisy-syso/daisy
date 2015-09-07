class Maternals::ConfinementCentersAPI < ApplicationAPI

  namespace :confinement_centers do
    index! Maternals::ConfinementCenter,
      title: "月子团购",
      filters: {
        type: type_filters("月子团购"), 
        city: city_filters,
        county: county_filters,
        order_by: order_by_filters(Maternals::ConfinementCenter),
        form: form_filters,
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("优惠返利"),
        template: form_radio_array_filters(%w(不限 妇幼医院 月子会所 月子服务 产后服务 孕产护理 月嫂/保姆),
          "当前主题精选")
      }

    show! Maternals::ConfinementCenter
  end
end
