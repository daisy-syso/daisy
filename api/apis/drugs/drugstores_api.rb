module Drugs
  class DrugstoresAPI < Grape::API
    extend ResourcesHelper

    namespace :drugstores do
      index! Drugs::Drugstore,
        title: "身边药房",
        filters: { 
          city: { default: 1, class: City, title: "位置" },
        }

      show! Drugs::Drugstore
    end

  end
end