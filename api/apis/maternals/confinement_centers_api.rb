class Maternals::ConfinementCentersAPI < ApplicationAPI

  namespace :confinement_centers do
    index! Maternals::ConfinementCenter,
      title: "月子中心",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        order_by: order_by_filters(Maternals::ConfinementCenter)
      }

    show! Maternals::ConfinementCenter
  end
end
