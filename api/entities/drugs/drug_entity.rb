module Drugs
  class DrugEntity < Grape::Entity
    expose :id, :name, :image_url, :ori_price, :sale_price

    expose :type do |object, options|
      "drug"
    end

  end
end