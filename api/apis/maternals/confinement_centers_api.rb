class Maternals::ConfinementCentersAPI < ApplicationAPI

  namespace :confinement_centers do
    index! Maternals::ConfinementCenter,
      title: "月子中心",
      filters: { 
        city: city_filters,
        zone: fake_zone_filters,
        order_by: order_by_filters(Maternals::ConfinementCenter)
      }

    show! Maternals::ConfinementCenter
  end
end
