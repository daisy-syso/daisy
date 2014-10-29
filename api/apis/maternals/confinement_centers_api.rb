class Maternals::ConfinementCentersAPI < ApplicationAPI

  namespace :confinement_centers do
    index! Maternals::ConfinementCenter,
      title: "月子中心",
      filters: { 
        city: city_filters,
        county: county_filters,
        order_by: order_by_filters(Maternals::ConfinementCenter),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters,
        has_url: form_switch_filters("网址", :has_url)
      }

    show! Maternals::ConfinementCenter
  end
end
