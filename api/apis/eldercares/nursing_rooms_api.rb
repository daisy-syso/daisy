class Eldercares::NursingRoomsAPI < Grape::API
  extend ResourcesHelper

  namespace :nursing_rooms do
    index! Eldercares::NursingRoom,
      title: "养老服务",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
      }

    show! Eldercares::NursingRoom
  end
  
end
