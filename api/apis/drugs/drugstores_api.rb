module Drugs
  class DrugstoresAPI < Grape::API
    extend ResourcesHelper

    index! :drugstores, 
      class: Drugs::Drugstore,
      title: "身边药房",
      filters: { 
        city: { default: 1, class: City, title: "位置" },
      }

  end
end