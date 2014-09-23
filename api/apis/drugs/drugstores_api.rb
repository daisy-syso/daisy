class Drugs::DrugstoresAPI < ApplicationAPI

  namespace :drugstores do
    index! Drugs::Drugstore,
      title: "身边药房",
      filters: { 
        city: city_filters,
        order_by: order_by_filters(Drugs::Drugstore)
      }

    show! Drugs::Drugstore
  end
end
