class PriceNotificationsAPI < Grape::API

  namespace :price_notifications do

    namespace :drugs do
      post :"drugs/:id" do
        record = current_user!.add_price_notification Drugs::Drug.find(params[:id]),
          params[:price]
        if record.save
          present :info, "成功添加降价通知"
        else
          failure! record
        end
      end
    end

  end

end