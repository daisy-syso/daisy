class Maternals::MaternalHallsAPI < ApplicationAPI

  namespace :maternal_halls do
    index! Maternals::MaternalHall,
      title: "月子中心",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        order_by: order_by_filters(Maternals::MaternalHall)
      }

    show! Maternals::MaternalHall
  end
end
