module Drugs
  class DrugEntity < Bases::ItemEntity
    expose :id, :name, :image_url, :ori_price, :sale_price

  end
end