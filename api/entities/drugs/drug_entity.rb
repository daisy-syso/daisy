class Drugs::DrugEntity < Bases::ItemEntity

  expose :image_url, :ori_price, :introduction, :brand, :spec
  expose :sale_price do |record, options|
    record.ori_price
  end
  expose 

  with_options if: { detail: true } do
    expose :code, :expiry_date
  end

end
