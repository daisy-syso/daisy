module Hospitals
  class NursingRoomEntity < Grape::Entity
    expose :id, :name, :image_url

    expose :type do |object, options|
      "nursing_room"
    end

    with_options if: { detail: true } do
      expose :address
    end

  end
end