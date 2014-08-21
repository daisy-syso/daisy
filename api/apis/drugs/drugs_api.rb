module Drugs
  class DrugsAPI < Grape::API

    params do
      optional :drug_type, type: Integer
    end
    get :drugs do
      has_scope :drug_type

      drug_type_current = params[:drug_type] ?
        Drugs::DrugType.find(params[:drug_type]).name : "全部"
      drug_type_children = Drugs::DrugType.filters_with_cache

      filters = [{ title: "药品类别", children: drug_type_children, current: drug_type_current }]
      data = apply_scopes!(Drugs::Drug.all)
      present! data, meta: { filters: filters, title: "药品大全" }
    end

    params do
      requires :id, type: Integer
    end
    get :"drug/:id" do
      present! Drugs::Drug.find(params[:id])
    end

  end
end