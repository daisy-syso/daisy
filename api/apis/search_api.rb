class SearchAPI < ApplicationAPI

  namespace :search do
    # post do
    #   i = 0
    #   begin
    #     i += 1
    #     result = Hospitals::Hospital.search(params[:query],
    #       page: params[:page] || 1,
    #       per_page: params[:per] || 10
    #     ).to_a
    #   rescue
    #     sleep(0.1)
    #   end until result || i > 3
    #   present title: "搜索结果"
    #   present :data, result, with: PolymorphicEntity
    # end

    get do
      has_scope :query
      data = apply_scopes! Hospitals::Hospital
      data = data.page(params[:per] || 10)
      present! data, with: PolymorphicEntity, meta: { title: "搜索结果", fin: false }
    end
  end

end