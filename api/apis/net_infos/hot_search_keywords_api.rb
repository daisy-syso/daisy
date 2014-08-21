module NetInfos
  class HotSearchKeywordsAPI < Grape::API

    get :keywords do
      present! NetInfos::HotSearchKeyword.all
    end

  end
end