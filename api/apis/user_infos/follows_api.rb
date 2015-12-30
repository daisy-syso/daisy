# 关注
class UserInfos::FollowsAPI < Grape::API
  namespace :follows do
    params do
      optional :disease_info_type_id, type: Integer
    end
    get do
      current_user!
      # 传了分类
      if params.disease_info_type_id.present?
        disease_info_type = Diseases::DiseaseInfoType.find(params.disease_info_type_id)
        informations = disease_info_type.informations

        present :data, informations, with: Informations::InformationEntity
      else
        follows = current_user!.follows
        arr = []
        big_hash = {}

        follows.each do |follow|
          top_name = follow.top_name
          # disease_info_type = follow.disease_info_type
          arr = {
            id: disease_info_type.id
            name: disease_info_type.name
          }

          if big_hash.keys.include? top_name.to_sym
            big_hash[top_name.to_sym] = big_hash[top_name.to_sym] << arr
          else
            big_hash[top_name.to_sym] = [arr]
          end
        end
        big_hash
      end
    end

    desc '添加关注'
    post do
      current_user!
      
      present :info, "关注成功"
    end

  end
end
