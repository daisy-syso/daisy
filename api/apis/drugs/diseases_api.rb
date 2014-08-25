module Drugs
  class DiseasesAPI < Grape::API
    extend ResourcesHelper

    resources :diseases, 
      class: Drugs::Disease,
      title: "疾病查询",
      filters: { 
        drug_type: { class: Drugs::DrugType, title: "疾病类别" },
      }

  end
end