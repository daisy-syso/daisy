module Drugs
  class DiseasesAPI < Grape::API
    extend ResourcesHelper

    namespace :diseases do
      index! Drugs::Disease,
        title: "疾病查询",
        filters: { 
          disease_type: { class: Drugs::DiseaseType, title: "疾病类别" },
        }
    end

  end
end