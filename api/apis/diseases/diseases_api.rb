class Diseases::DiseasesAPI < Grape::API
  extend ResourcesHelper

  namespace :diseases do
    index! Diseases::Disease,
      title: "疾病查询",
      filters: { 
        disease_type: { class: Diseases::DiseaseType, title: "疾病类别" },
      }

    show! Diseases::Disease
  end

end
