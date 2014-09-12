class Maternals::MaternalHallsAPI < Grape::API
  extend ResourcesHelper

  namespace :maternal_halls do
    index! Maternals::MaternalHall,
      title: "月子中心",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
      }

    show! Maternals::MaternalHall
  end
end
