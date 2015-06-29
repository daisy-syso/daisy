class Drugs::DrugEntity < Bases::ItemEntity

  expose :image_url, :ori_price, :introduction, :brand, :spec, :manufactory, :expiry_date, :code
  expose :sale_price do |record|
    record.ori_price
  end
end
