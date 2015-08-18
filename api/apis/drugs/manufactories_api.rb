class Drugs::ManufactoriesAPI < ApplicationAPI

  namespace :manufactories do
    index! Drugs::Manufactory,
      title: "品牌药企",
      filters: { 
        type: type_filters("品牌药企", :manufactory),
        county: county_filters,
        order_by: order_by_filters(Drugs::Drugstore),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters
      }

    show! Drugs::Manufactory
  end
end