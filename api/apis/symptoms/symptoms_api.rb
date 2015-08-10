class Symptoms::SymptomsAPI < ApplicationAPI
  format :json

  namespace :symptoms do

    index! Symptoms::Part,
      title: '症状查询',
      filters: {
        type: type_filters("症状查询", :symptom),
         symptom_type: { scope_only: true },
         symptom_id: { scope_only: true },
         search_by: search_by_filters({
           default: :part,
           part: { title: "症状部位", class: Symptoms::Part },
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
    
  end
end
