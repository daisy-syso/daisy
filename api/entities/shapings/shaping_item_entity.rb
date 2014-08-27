module Shapings
  class ShapingItemEntity < Grape::Entity
    expose :id, :name

    expose :type do |object, options|
      "shaping_item"
    end

  end
end