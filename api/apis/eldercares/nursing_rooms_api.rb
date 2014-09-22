class Eldercares::NursingRoomsAPI < ApplicationAPI

  namespace :nursing_rooms do
    index! Eldercares::NursingRoom,
      title: "养老服务",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        order_by: order_by_filters(Eldercares::NursingRoom)
      }

    show! Eldercares::NursingRoom
  end
end
