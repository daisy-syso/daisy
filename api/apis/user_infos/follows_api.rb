# 关注
class UserInfos::FollowsAPI < Grape::API
  namespace :follows do
    params do
      optional :disease_info_type_id, type: Integer
    end
    desc '我的关注'
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
          disease_info_type = Diseases::DiseaseInfoType.find(follow.disease_info_type_id)
          arr = {
            id: disease_info_type.id,
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

    desc '全部分类'
    get 'all_disease_info_types' do
      big_hash = {}

      Diseases::DiseaseInfoType.where(parent_id: nil).each do |follow|
        top_name = follow.name
        disease_info_types = Diseases::DiseaseInfoType.where(parent_id: follow.id)

        disease_info_types.each do |disease_info_type|
          arr = {
            id: disease_info_type.id,
            name: disease_info_type.name
          }

          if big_hash.keys.include? top_name.to_sym
            big_hash[top_name.to_sym] = big_hash[top_name.to_sym] << arr
          else
            big_hash[top_name.to_sym] = [arr]
          end
        end
      end
      big_hash
    end

    desc '添加关注'
    params do
      optional :disease_info_type_ids, type: String
    end
    post do
      current_user!

      message = ""
      params.disease_info_type_ids.split(',').each do |id|
        follow = current_user!.follows.find_or_initialize_by(disease_info_type_id: id.to_i)
        if follow.new_record?
          follow.save
          message += "#{Diseases::DiseaseInfoType.find(id).name} 关注成功,"
        else
          message += "#{Diseases::DiseaseInfoType.find(id).name} 已经被关注,"
        end
      end
      present :info, message
    end
  end
end
