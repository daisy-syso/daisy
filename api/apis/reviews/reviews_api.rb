class Reviews::ReviewsAPI < ApplicationAPI

  format :json

  namespace :reviews_new do

    params do
      requires :item_type, type: String, desc: '类型'
      requires :item_id, type: Integer, desc: '类型的ID'
      requires :desc, type: String, desc: '描述'
      requires :account_id, type: Integer, desc: '用户ID'
      requires :environment, type: Integer, desc: '环境'
      requires :service, type: Integer, desc: '服务'
      requires :charge, type: Integer, desc: '收费'
      requires :technique, type: Integer, desc: '技术'
    end
    post '/' do
      review = UserInfos::Review.new(
        item_type: params[:item_type],
        item_id: params[:item_id],
        desc: params[:desc],
        account_id: params[:account_id],
        environment: params[:environment],
        service: params[:service],
        charge: params[:charge],
        technique: params[:technique],
        star: 5
        )


      if review.save

        present review
      end
    end
  end
end
