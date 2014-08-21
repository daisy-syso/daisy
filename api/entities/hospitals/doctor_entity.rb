module Hospitals
  class DoctorEntity < Grape::Entity
    expose :id, :name

    expose :type do |object, options|
      "doctor"
    end

  end
end