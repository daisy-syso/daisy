class Drugs::DrugstoresAPI < ApplicationAPI

  namespace :drugstores do
    index! Drugs::Drugstore,
      title: "身边药房",
      filters: { 
        extension: { scope_only: true, default: 1, type: Integer},
        city: city_filters,
        type: type_filters("身边药房", :drugstore),
        county: county_filters,
        # search_by: search_by_filters({
        #   alphabet: alphabet_filters
        # }),
        # alphabet: alphabet_filters,
        order_by: order_by_filters(Drugs::Drugstore),
        form: form_filters,
        query: form_query_filters, 
        alphabet: form_alphabet_filters,
        is_local_hot: form_switch_filters("热门药店")
      }
    get "/:id/drugs" do 
      drugstore = Drugs::Drugstore.where(id: params[:id]).first
      present :data, drugstore.drugs.page(params[:page])
      # present! drugstore.drugs
    end
    show! Drugs::Drugstore
  end
end
