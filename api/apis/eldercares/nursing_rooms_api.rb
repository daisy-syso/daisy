class Eldercares::NursingRoomsAPI < ApplicationAPI

  namespace :nursing_rooms do
    index! Eldercares::NursingRoom,
      title: "养老服务",
      filters: { 
        city: city_filters,
        order_by: order_by_filters(Eldercares::NursingRoom)
      }

    show! Eldercares::NursingRoom
  end
end
