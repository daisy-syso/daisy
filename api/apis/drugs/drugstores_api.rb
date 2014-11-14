class Drugs::DrugstoresAPI < ApplicationAPI

  namespace :drugstores do
    index! Drugs::Drugstore,
      title: "身边药房",
      filters: { 
        city: city_filters,
        type: type_filters(:drugstore),
        county: county_filters,
        order_by: order_by_filters(Drugs::Drugstore),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters,
        is_local_hot: form_switch_filters("热门药店")
      }

    show! Drugs::Drugstore
  end
end
