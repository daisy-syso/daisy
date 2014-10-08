class SearchAPI < ApplicationAPI

  namespace :search do
    post do
      result = Hospitals::Hospital.search(params[:query], 
        page: params[:page] || 1, 
        per_page: params[:per] || 10
      )
      present title: "搜索结果"
      present :data, result, with: PolymorphicEntity
    end
  end

end