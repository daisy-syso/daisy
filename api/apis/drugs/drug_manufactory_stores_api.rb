class Drugs::DrugManufactoryStoresAPI < ApplicationAPI

  namespace :drug_manufactory_stores do
    index! Drugs::DrugManufactoryStore,
      title: "团购药品",
      filters: { 
        type: type_filters("团购药品", :drug_manufactory_store),
        county: county_filters,
        order_by: order_by_filters(Drugs::DrugManufactoryStore),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters
      }

  end
end