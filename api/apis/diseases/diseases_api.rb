class Diseases::DiseasesAPI < ApplicationAPI

  namespace :diseases do
    index! Diseases::Disease,
      title: "疾病查询",
      filters: { 
        disease_type: { class: Diseases::DiseaseType, title: "类别" },
        order_by: order_by_filters(Diseases::Disease),
        form: form_filters,
        drug_query: form_query_filters("相关药品", :drug_query), 
        doctor_query: form_query_filters("相关医生", :doctor_query), 
        hospital_query: form_query_filters("相关医院", :hospital_query), 
        alphabet: form_alphabet_filters,
      }

    show! Diseases::Disease
  end

  namespace :"diseases/:id" do
    namespace :hospitals do
      index! Hospitals::Hospital,
        title: "相关医院",
        parent: proc { Diseases::Disease.find(params[:id]).hospitals },
        filters: { 
          city: city_filters,
          hospital_type: { class: Hospitals::HospitalType, title: "类别" },
          zone: fake_zone_filters,
          order_by: order_by_filters(Diseases::Disease)
        }
    end

    namespace :doctors do
      index! Hospitals::Doctor,
        title: "相关医生",
        parent: proc { Diseases::Disease.find(params[:id]).doctors },
        filters: { 
          city: city_filters,
          # hospital: { 
          #   class: Hospitals::Hospital, 
          #   title: "医院",
          #   meta: { filterable: true },
          #   children: proc { Hospitals::Hospital.limit(100).filters(params[:city]) }
          # },
          hospital_room: { class: Hospitals::HospitalRoom, title: "类别" },
          zone: fake_zone_filters,
          order_by: order_by_filters(Diseases::Disease)
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "相关药品",
        parent: proc { Diseases::Disease.find(params[:id]).drugs },
        filters: { 
          drug_type: { class: Drugs::DrugType, title: "类别" },
          zone: fake_zone_filters,
          order_by: order_by_filters(Diseases::Disease)
        }
    end
  end
end
