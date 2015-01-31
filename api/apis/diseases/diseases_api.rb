class Diseases::DiseasesAPI < ApplicationAPI

  namespace :diseases do
    index! Diseases::Disease,
      title: "疾病查询",
      filters: { 
        type: type_filters("疾病查询", :disease),
        disease_type: { scope_only: true },
        search_by: search_by_filters({
          default: :symptom,
          symptom: { title: "症状", class: Diseases::Symptom },
          hospital_room: { title: "科室", class: Hospitals::HospitalRoom },
          alphabet: alphabet_filters,
          common_disease: common_diseas_filters,
          disease_type: { title: "疾病类别", class: Diseases::DiseaseType}
        }),
        order_by: order_by_filters(Diseases::Disease),
        form: form_filters,
        query: form_query_filters, 
        drug_query: form_query_filters("相关药品"), 
        doctor_query: form_query_filters("相关医生"), 
        hospital_query: form_query_filters("相关医院"), 
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
          # hospital_type: { class: Hospitals::HospitalType, title: proc { Hospitals::HospitalType.find_by_id(params[:hospital_type]).try(:name) || "全部" } },
          hospital_type: hospital_type_filters,
          county: fake_county_filters,
          order_by: order_by_filters(Diseases::Disease),
          form: form_filters,
          query: form_query_filters, 
          alphabet: form_alphabet_filters,
          hospital_level: form_radio_filters(Hospitals::HospitalLevel, 
            "医院等级"),
          has_url: form_switch_filters("网址"),
          is_local_hot: form_switch_filters("热门医院")
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
          county: fake_county_filters,
          order_by: order_by_filters(Diseases::Disease),
          form: form_filters,
          query: form_query_filters, 
          position_query: form_query_filters("职称"), 
          hospital_query: form_query_filters("所属医院"), 
          alphabet: form_alphabet_filters
        }
    end

    namespace :drugs do
      index! Drugs::Drug,
        title: "相关药品",
        parent: proc { Diseases::Disease.find(params[:id]).drugs },
        filters: { 
          # city: fake_city_filters,
          # drug_type: { class: Drugs::DrugType, title: "类别" },
          disease: { title: "疾病", class: Diseases::Disease },
          # search_by: search_by_filters({
          #   default: :disease,
          #   disease: { title: "疾病", class: Diseases::Disease },
          #   hospital_room: { title: "科室", class: Hospitals::HospitalRoom },
          #   alphabet: alphabet_filters
          # }),
          county: fake_county_filters,
          order_by: order_by_filters(Diseases::Disease),
          form: form_filters,
          query: form_query_filters, 
          price: form_price_filters,
          manufactory_query: form_radio_array_filters(
            %w(三精制药 同仁堂 修正药业 太极集团), "品牌"),
          alphabet: form_alphabet_filters
        }
    end

  #   namespace :drugs do
  #     {
  #       title: "相关药品",
  #       filters
  #     }

  end
end
