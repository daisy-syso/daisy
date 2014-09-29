class Drugs::DrugsAPI < ApplicationAPI

  namespace :drugs do 
    index! Drugs::Drug,
      title: "药品大全",
      filters: { 
        drug_type: { class: Drugs::DrugType, title: "药品类别" },
        zone: zone_filters,
        order_by: order_by_filters(Drugs::Drug)
      }

    show! Drugs::Drug
  end
end
