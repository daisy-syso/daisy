class Drugs::DrugsAPI < ApplicationAPI

  namespace :drugs do 
    index! Drugs::Drug,
      title: "药品大全",
      filters: { 
        city: fake_city_filters,
        drug_type: { class: Drugs::DrugType, title: "类别" },
        zone: fake_zone_filters,
        order_by: order_by_filters(Drugs::Drug)
      }

    show! Drugs::Drug
  end
end
