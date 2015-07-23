class Symptoms::SymptomsAPI < ApplicationAPI
  format :json

  namespace :symptoms do
    index! Symptoms::Symptom,
      title: "症状查询",
      filters: {
        type: type_filters("疾病查询", :symptom),
        symptom_type: { scope_only: true },
        symptom_id: { scope_only: true },
        search_by: search_by_filters({
          default: :symptom,
          symptom: { title: "症状", class: Symptoms::Symptom },
          hospital_room: { title: proc { Hospitals::HospitalRoom.find_by_id(params[:hospital_room]).try(:name) || "科室" }, class: Hospitals::HospitalRoom, method: :menu_list, children: proc { Hospitals::HospitalRoom.parent_menu}, current: nil  },
          alphabet: alphabet_filters,
          common_disease: common_diseas_filters,
        }),
        order_by: order_by_filters(Symptoms::Symptom),
        form: form_filters,
        query: form_query_filters,
        drug_query: form_query_filters("相关药品"),
        doctor_query: form_query_filters("相关医生"),
        hospital_query: form_query_filters("相关医院"),
        alphabet: form_alphabet_filters,
      }

    show! Symptoms::Symptom

    params do
      optional :id, type: Integer, desc: 'ID'
    end
    get '/:id' do
      symptom = Symptoms::Symptom.find(params[:id])

      symptom_result = {
        id: symptom.id,
        name: symptom.name,
        xgjc: symptom.xgjc,
        xgzz: symptom.xgzz,
        xgyp: symptom.xgyp,
        xgjb: symptom.xgjb
      }

      symptom_details = Symptoms::SymptomDetail.where(detail_id: symptom.detail_id)

      symptom_detail_results = []

      symptom_details.each do |sd|
        tmp = {
          title: sd.title,
          detail: sd.detail,
          image_url: sd.image_url
        }
        symptom_detail_results << tmp
      end

      {
        symptoms: {
          symptom: symptom_result,
          details: symptom_detail_results
        }
      }

    end
  end
end
