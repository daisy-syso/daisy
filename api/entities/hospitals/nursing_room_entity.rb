module Hospitals
  class NursingRoomEntity < Grape::Entity
    expose :id, :name, :image_url, :address

    expose :type do |object, options|
      "nursing_room"
    end

  end
end