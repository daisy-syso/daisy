class JoinApplies::JoinAppliesAPI < ApplicationAPI
  format :json

  namespace :join_applies do
    params do
      requires :email, type: String
      requires :target_type, type: Integer
      requires :target_attrs, type: Hash

      optional :contact_user, type: String
      optional :contact_phone, type: String
    end

    post :post_apply do
      target_type = JoinApplies::JoinApply::TARGET_TYPES[params[:target_type]]
      target_attrs = params[:target_attrs].except(:id).merge({status: 0})

      if target_type.present?
        target_model = eval(target_type)

        ActiveRecord::Base.transaction do
          item = target_model.new

          target_attrs.each do |field|
            # if target_model.respond_to?(attr[0])
            if target_model.column_names.include?(field[0])
              item.send("#{field[0]}=", field[1])
            else
              target_attrs.except!(field[0])
            end
          end

          item.save!
          join_apply = JoinApplies::JoinApply.create!(
            email: params[:email],
            contact_user: params[:contact_user],
            contact_phone: params[:contact_phone],
            target: item,
            status: 0
          )
        end
      else
        error!('500 加盟类型错误', 500)
      end
    end

    get '/' do
      join_applies = JoinApplies::JoinApply.all

      {symptoms: join_applies}
    end

    get :apply_types do
      apply_types = JoinApplies::JoinApply::TARGET_TYPES_MAPPING
      {apply_types: apply_types}
    end

  end
end
