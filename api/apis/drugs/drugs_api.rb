class Drugs::DrugsAPI < ApplicationAPI

  namespace :drugs do 
    index! Drugs::Drug,
      title: "药品大全",
      filters: { 
        city: fake_city_filters,
        type: type_filters("药品大全", :drug),
        search_by: search_by_filters({
          default: :disease,
          disease: { title: proc { Drugs::DrugType.where(id: params[:disease]).first.try(:name) || "疾病"}, class: Drugs::DrugType },
          hospital_room: { title: "科室", class: Hospitals::HospitalRoom },
          alphabet: alphabet_filters,
          manufactory: {title: "品牌", class: Drugs::Manufactory }
        }),
        order_by: order_by_filters(Drugs::Drug),
        form: form_filters,
        query: form_query_filters, 
        price: form_price_filters,
        manufactory_query: form_radio_array_filters(
          %w(三精制药 同仁堂 修正药业 太极集团), "品牌"),
        alphabet: form_alphabet_filters
      }

    show! Drugs::Drug
  end
end
