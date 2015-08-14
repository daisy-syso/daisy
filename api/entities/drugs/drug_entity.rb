class Drugs::DrugEntity < Bases::ItemEntity

  # expose :image_url, :ori_price, :introduction, :brand, :spec, :manufactory, :expiry_date, :code
  # expose :sale_price do |record|
  #   record.ori_price
  # end

  expose :image_url, :spec, :code

  with_options if: {kinds_of_drug: true} do
  	expose :factory_count
  	expose :brand
  end

  with_options if: {kinds_of_drug: false} do
  	expose :manufactory
  	# expose :drugstore_count
  	expose :ori_price
  end

end
