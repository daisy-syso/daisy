class Drugs::DrugEntity < Bases::ItemEntity

  # expose :image_url, :ori_price, :introduction, :brand, :spec, :manufactory, :expiry_date, :code
  # expose :sale_price do |record|
  #   record.ori_price
  # end

  expose :image_url, :spec, :code, :ori_price, :manufactory, :introduction, :is_otc, :price

  expose :price_scope do |object, options|
    prices = object.drug_manufactory_stores.where.not("drug_manufactory_stores.price is null").pluck(:price).delete_if(&:blank?).map(&:to_i)
    if prices.blank?
      ""
    else
      "#{prices.min}-#{prices.max}" 
    end
  end
  with_options if: {kinds_of_drug: true} do 
  	expose :factory_count
  	expose :brand
    expose :factory_price_scope do |obj, opts|
      prices = Drugs::Drug.where(name: obj.name).pluck(:price).delete_if(&:blank?).map(&:to_i)
      if prices.blank?
      ""
      else
        "#{prices.min}-#{prices.max}" 
      end
    end
  end

  with_options if: {kinds_of_drug: false} do
  	# expose :manufactory, :introduction
    expose :manufactory_id do |obj|
      Drugs::Manufactory.where(name: obj.manufactory).first.id
    end 
  	expose :drugstore_count do |obj, opt|
      obj.drugstores.includes(:drug_manufactory_stores).where.not("drug_manufactory_stores.price is null").count
    end

  end

  with_options if: { detail: true } do
    expose :brand
    # expose :introduction
    expose :drug_details
    expose :drugstores do |obj, opt|
      obj.drugstores.map do |store|
        # store.instance_eval do 
        #   self[:price] = obj.drug_manufactory_stores.where(drugstore_id: store.id).first.price
        # end
        price = obj.drug_manufactory_stores.where.not("drug_manufactory_stores.price is null").where(drugstore_id: store.id).first.price
        # store.instance_variable_set(:@price, price)
        store.attributes.merge({price: obj.drug_manufactory_stores.where(drugstore_id: store.id).first.price })
      end
    end
  end

end
