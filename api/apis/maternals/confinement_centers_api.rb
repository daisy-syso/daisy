class Maternals::ConfinementCentersAPI < Grape::API
  extend ResourcesHelper

  namespace :confinement_centers do
    index! Maternals::ConfinementCenter,
      title: "月子中心",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
      }

    show! Maternals::ConfinementCenter
  end
end
