class Hospitals::HospitalChargesAPI < ApplicationAPI

  namespace :polyclinic_treatments do
    index! Diseases::Disease, 
      title: "诊疗攻略",
      with: Hospitals::PolyclinicTreatmentEntity,
      filters: { 
        type: type_filters,
        city: fake_city_filters,
        county: fake_county_filters,
        order_by: order_by_filters(Diseases::Disease),
        form: form_filters
      }

    show! Diseases::Disease
  end

  namespace :polyclinic_charges do
    index! Hospitals::PolyclinicCharge, 
      title: "价格攻略",
      filters: { 
        type: type_filters,
        city: city_filters,
        province: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(Hospitals::PolyclinicCharge),
        form: form_filters
      }
  end 

  namespace :hospital_charges do
    params do
      requires :hospital_parent_type, type: Integer
    end
    # p params[:hospital_parent_type]
    index! Hospitals::HospitalCharge, 
      meta: { nolink: true },
      # parent: proc { Hospitals::HospitalCharge.where(hospital_type_id: params[:type])},
      title: "价格攻略",
      filters: { 
        type: type_filters,
        hospital_parent_type: { scope_only: true },
        hospital_type: { scope_only: true },
        county: hospital_charge_type,
        order_by: order_by_filters(Hospitals::HospitalCharge),
        form: form_filters
      }
  end

  namespace :"hospital_type/:id" do
    namespace :hospitals do
      index! Hospitals::Hospital,
        title: "相关医院",
        parent: proc { Hospitals::HospitalType.find(params[:id]).hospitals },
        filters: { 
          city: city_filters,
          hospital_type: { class: Hospitals::HospitalType, title: "类别" },
          county: fake_county_filters,
          order_by: order_by_filters(Hospitals::HospitalType),
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
          drug_type: { class: Drugs::DrugType, title: "类别" },
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
  end
end