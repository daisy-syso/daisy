class Drugs::DrugEntity < Bases::ItemEntity

  expose :image_url, :ori_price, :sale_price
  
  with_options if: { detail: true } do
  end

end
