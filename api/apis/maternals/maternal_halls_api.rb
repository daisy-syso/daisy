class Maternals::MaternalHallsAPI < ApplicationAPI

  namespace :maternal_halls do
    index! Maternals::MaternalHall,
      title: "母婴会馆",
      filters: { 
        city: city_filters,
        zone: fake_zone_filters,
        order_by: order_by_filters(Maternals::MaternalHall)
      }

    show! Maternals::MaternalHall
  end
end
