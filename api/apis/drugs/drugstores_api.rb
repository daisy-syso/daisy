class Drugs::DrugstoresAPI < ApplicationAPI

  namespace :drugstores do
    index! Drugs::Drugstore,
      title: "身边药房",
      filters: { 
        extension: { scope_only: true, default: 1, type: Integer},
        city: city_filters,
        type: type_filters("身边药房", :drugstore),
        county: county_filters,
        order_by: order_by_filters(Drugs::Drugstore),
        form: form_filters,
        query: form_query_filters, 
        # is_local_hot: form_switch_filters("热门药店")
        appointment: form_switch_filters("无需预约"),
        has_return: form_switch_filters("优惠返利"),
        theme: form_radio_array_filters(%w(定点药房 24小时营业 网上药店资质 连锁药店 品质药店加盟商), "主题精选")
      }
    get "/:id/drugs" do 
      drugstore = Drugs::Drugstore.where(id: params[:id]).first
      present :data, drugstore.drugs.page(params[:page])
      # present! drugstore.drugs
    end
    get "/:drugstore_id/drugs/:drug_id" do 
      drugstore = Drugs::Drugstore.where(id: params[:drugstore_id]).first
      drug = drugstore.drugs.where(id: params[:drug_id]).first
      present :drug, drug
      present :drugstore, drugstore
      # present! drugstore.drugs
    end
    show! Drugs::Drugstore
  end
end
