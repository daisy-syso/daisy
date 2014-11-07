class Hospitals::DoctorsAPI < ApplicationAPI

  namespace :doctors do
    index! Hospitals::Doctor,
      title: "找医生",
      filters: {
        city: city_filters,
        type: type_filters(3000),
        hospital_room: { scope_only: true },
        county: county_filters,
        order_by: order_by_filters(Hospitals::Doctor),
        form: form_filters,
        query: form_query_filters, 
        position_query: form_query_filters("职称"), 
        hospital_query: form_query_filters("所属医院"), 
        alphabet: form_alphabet_filters
      }

    show! Hospitals::Doctor
  end
end
