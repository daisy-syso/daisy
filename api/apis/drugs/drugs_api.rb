module Drugs
  class DrugsAPI < Grape::API
    extend ResourcesHelper

    resources :drugs, 
      class: Drugs::Drug,
      title: "药品大全",
      filters: { 
        drug_type: { class: Drugs::DrugType, title: "药品类别" },
      }

  end
end