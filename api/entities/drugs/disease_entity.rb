module Drugs
  class DiseaseEntity < Grape::Entity
    expose :id, :name

    expose :type do |object, options|
      "disease"
    end

  end
end