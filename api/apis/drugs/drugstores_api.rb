class Drugs::DrugstoresAPI < ApplicationAPI

  namespace :drugstores do
    index! Drugs::Drugstore,
      title: "身边药房",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        order_by: order_by_filters(Drugs::Drugstore)
      }

    show! Drugs::Drugstore
  end
end
