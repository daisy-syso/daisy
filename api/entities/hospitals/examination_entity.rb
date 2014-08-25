module Hospitals
  class ExaminationEntity < Grape::Entity
    expose :id, :name

    expose :type do |object, options|
      "hospital"
    end

  end
end