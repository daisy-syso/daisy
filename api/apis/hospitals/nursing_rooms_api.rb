module Hospitals
  class NursingRoomsAPI < Grape::API
    extend ResourcesHelper

    resources :nursing_rooms, 
      class: Hospitals::NursingRoom,
      title: "养老服务",
      filters: { 
        city: { default: 1, class: City, title: "位置" },
      }
    
  end
end