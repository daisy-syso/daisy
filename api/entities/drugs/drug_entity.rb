class Drugs::DrugEntity < Bases::ItemEntity

  expose :image_url, :ori_price, :introduction, :brand, :spec, :manufactory
  expose :sale_price do |record, options|
    record.ori_price
  end

  expose :drug_sevice_list do |instance, options|
    {
      :cfy => false,
      :xy => false,
      :ybdd => false
    }
  end 

  with_options if: { detail: true } do
    expose :code, :expiry_date
  end

end
