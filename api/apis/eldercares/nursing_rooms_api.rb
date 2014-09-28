class Eldercares::NursingRoomsAPI < ApplicationAPI

  Types = {
    :"eldercares/nursing_rooms" => "养老院"
  }

  namespace :nursing_rooms do
    index! Eldercares::NursingRoom,
      title: "养老服务",
      filters: { 
        city: city_filters,
        type: type_filters(Types),
        zone: zone_filters,
        order_by: order_by_filters(Eldercares::NursingRoom)
      }

    show! Eldercares::NursingRoom
  end
end
