class Drugs::DrugEntity < Bases::ItemEntity

  # expose :image_url, :ori_price, :introduction, :brand, :spec, :manufactory, :expiry_date, :code
  # expose :sale_price do |record|
  #   record.ori_price
  # end

  expose :image_url, :spec, :code, :ori_price

  with_options if: {kinds_of_drug: true} do
  	expose :factory_count
  	expose :brand
  end

  with_options if: {kinds_of_drug: false} do
  	expose :manufactory
  	expose :drugstore_count do |obj, opt|
      obj.drugstores.joins(:drug_manufactory_stores).where.not("drug_manufactory_stores.price is null").count
    end
    expose :introduction
  end

  with_options if: { detail: true } do
    expose :brand
    expose :drug_details
    expose :drugstores do |obj, opt|
      obj.drugstores.map do |store|
        # store.instance_eval do 
        #   self[:price] = obj.drug_manufactory_stores.where(drugstore_id: store.id).first.price
        # end
        price = obj.drug_manufactory_stores.joins(:drug_manufactory_stores).where.not("drug_manufactory_stores.price is null").where(drugstore_id: store.id).first.price
        # store.instance_variable_set(:@price, price)
        store.attributes.merge({price: obj.drug_manufactory_stores.where(drugstore_id: store.id).first.price })
      end
    end
  end

end
