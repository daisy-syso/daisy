module Hospitals
  class NursingRoomsAPI < Grape::API
    extend ResourcesHelper

    namespace :nursing_rooms do
      index! Hospitals::NursingRoom,
        title: "养老服务",
        filters: { 
          city: { default: 1, class: City, title: "位置" },
        }
    end
    
  end
end