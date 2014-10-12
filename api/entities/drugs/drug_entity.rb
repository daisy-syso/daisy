class Drugs::DrugEntity < Bases::ItemEntity

  expose :image_url, :ori_price
  expose :sale_price do |record, options|
    record.ori_price
  end
  
  with_options if: { detail: true } do
    expose :introduction
  end

end
