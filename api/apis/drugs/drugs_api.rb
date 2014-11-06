class Drugs::DrugsAPI < ApplicationAPI

  namespace :drugs do 
    index! Drugs::Drug,
      title: "药品大全",
      filters: { 
        city: fake_city_filters,
        type: type_filters(4000),
        disease: { scope_only: true },
        county: fake_county_filters,
        order_by: order_by_filters(Drugs::Drug),
        form: form_filters,
        query: form_query_filters, 
        price: form_price_filters,
        manufactory_query: form_radio_array_filters(
          %w(三精制药 同仁堂 修正药业 太极集团), "品牌", :manufactory_query),
        alphabet: form_alphabet_filters
      }

    show! Drugs::Drug
  end
end
