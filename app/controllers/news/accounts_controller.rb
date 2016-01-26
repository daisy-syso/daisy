class News::AccountsController < NewsController

  def mine

    unless news_account_signed_in?
      redirect_to new_news_account_session_url
      return 
    end

    @user = current_news_account

    follows = current_news_account.follows

    arr = []
    big_hash = {}

    result = []

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
      big_hash
    end

    @tt = big_hash
  end

  def follow
    unless news_account_signed_in?
      redirect_to new_news_account_session_url
    end

    follow = current_news_account.follows.find_or_initialize_by(disease_info_type_id: params[:disease_info_type_id].to_i)

    name = Diseases::DiseaseInfoType.find(params[:disease_info_type_id].to_i).name
    if follow.new_record?
      follow.save
      message = "#{name} 关注成功"
    end

    flash[:alert] = message

    redirect_to news_accounts_following_list_path
  end

  def delete_follow
    unless news_account_signed_in?
      redirect_to new_news_account_session_url
    end

    follow = current_news_account.follows.where(disease_info_type_id: params[:disease_info_type_id].to_i).first
    name = Diseases::DiseaseInfoType.find(params[:disease_info_type_id].to_i).name
    if follow.destroy
      message = "#{name} 已取消关注"
    end

    flash[:alert] = message

    redirect_to news_accounts_following_list_path
  end

  def following_list
    unless news_account_signed_in?
      redirect_to new_news_account_session_url
      return 
    end
    
    big_hash = {}

    disease_info_type_ids = current_news_account.follows.pluck(:disease_info_type_id)

    Diseases::DiseaseInfoType.where(parent_id: nil).each do |follow|
      top_name = follow.name
      disease_info_types = Diseases::DiseaseInfoType.where(parent_id: follow.id)

      disease_info_types.each do |disease_info_type|
        if Diseases::DiseaseInfo.where(disease_info_type_id: disease_info_type.id).present?
          arr = {
            id: disease_info_type.id,
            name: disease_info_type.name,
            has_followed: disease_info_type_ids.include?(disease_info_type.id)
          }

          if big_hash.keys.include? top_name.to_sym
            big_hash[top_name.to_sym] = big_hash[top_name.to_sym] << arr
          else
            big_hash[top_name.to_sym] = [arr]
          end
        end
      end
    end
    big_hash

    @big_hash = big_hash
  end

end
