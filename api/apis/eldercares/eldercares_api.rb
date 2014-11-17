class Eldercares::EldercaresAPI < ApplicationAPI

  namespace :nursing_rooms do
    index! Eldercares::NursingRoom,
      title: "养老公寓",
      filters: { 
        city: city_filters,
        type: type_filters(:eldercare),
        county: county_filters,
        order_by: order_by_filters(Eldercares::NursingRoom),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters
      }

    show! Eldercares::NursingRoom
  end
end
