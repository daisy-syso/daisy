module Hospitals
  class HospitalEntity < Grape::Entity
    expose :id, :name, :image_url

    expose :type do |object, options|
      "hospital"
    end

    with_options if: { detail: true } do
      expose :address
    end

  end
end