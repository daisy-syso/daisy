class PriceNotificationsAPI < Grape::API

  namespace :price_notifications do

    namespace :drugs do
      post :"drugs/:id" do
        record = PriceNotification.new({
          item: Drugs::Drug.find(params[:id]),
          price: params[:price],
          account: current_user!
        })
        if record.save
        else
          failure! record
        end
      end
    end

  end

end