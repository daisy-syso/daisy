module Drugs
  class DiseasesAPI < Grape::API
    extend ResourcesHelper

    index! :diseases, 
      class: Drugs::Disease,
      title: "疾病查询",
      filters: { 
        disease_type: { class: Drugs::DiseaseType, title: "疾病类别" },
      }

  end
end