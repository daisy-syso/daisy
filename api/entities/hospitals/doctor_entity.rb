module Hospitals
  class DoctorEntity < Grape::Entity
    expose :id, :name, :desc

    expose :type do |object, options|
      "doctor"
    end

  end
end