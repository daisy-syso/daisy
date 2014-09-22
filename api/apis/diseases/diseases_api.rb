class Diseases::DiseasesAPI < ApplicationAPI

  namespace :diseases do
    index! Diseases::Disease,
      title: "疾病查询",
      filters: { 
        disease_type: { class: Diseases::DiseaseType, title: "疾病类别" },
      }

    show! Diseases::Disease
  end

  namespace :"diseases/:id" do
    namespace :hospitals do
      index! Hospitals::Hospital,
        title: "相关医院",
        parent: -> (params) { Diseases::Disease.find(params[:id]).hospitals },
        filters: { 
          city: { default: 1, class: Categories::City, title: "位置" },
          hospital_type: { class: Hospitals::HospitalType, title: "医院类型" }
        }
    end

    namespace :doctors do
      index! Hospitals::Doctor,
        title: "相关医生",
        parent: -> (params) { Diseases::Disease.find(params[:id]).doctors },
        filters: { 
          hospital: { class: Hospitals::Hospital, title: "医院" },
          hospital_room: { class: Hospitals::HospitalRoom, title: "医院科室" }
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "相关药品",
        parent: -> (params) { Diseases::Disease.find(params[:id]).drugs },
        filters: { 
          drug_type: { class: Drugs::DrugType, title: "药品类别" },
        }
    end
  end
end
