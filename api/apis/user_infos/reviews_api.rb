class UserInfos::ReviewsAPI < Grape::API

  namespace :reviews do

    post :"(*:type_and_id)", anchor: false do
      match = env["PATH_INFO"].match(/(?<type>.*)\/(?<id>[^\/.?]+)/)
      klass = match[:type].classify.constantize
      record = current_user!.add_review klass.find(match[:id]),
        params[:review][:star], params[:review][:desc]
      if record.save
        present :info, "成功发表评价"
      else
        failure! record
      end
    end

  end
end
