class Examinations::ExaminationTypesAPI < ApplicationAPI

  namespace :examination_type do
    index! Examinations::ExaminationType,
      title: "全国体检",
      filters: { 
        # city: city_filters,
        type: type_filters(:examination),
        examination_type: { scope_only: true },
        examination_parent_type: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(Examinations::Examination),
        form: form_filters,
        query: form_query_filters,
        price: form_price_filters, 
        alphabet: form_alphabet_filters,
        hospital_query: form_radio_array_filters(
          %w(爱康国宾 美年大 慈铭体检 阳光体检), "品牌"),
        applicable_query: form_radio_array_filters(
          %w(男性 女性 白领 亚健康), "适应人群")
      }
      
    show! Examinations::Examination
  end
end
