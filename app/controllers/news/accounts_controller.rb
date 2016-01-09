class News::AccountsController < NewsController
  # before_action :check_auth, except: [:register, :login, :logn_in, :logn_out]
  # before_action :authenticate_account!

  def mine
    # debugger
    # unless account_signed_in?
      # redirect_to new_news_account_session_url
    # end

    # debugger

    # current_account
    # debugger
    @disease_info_types = Diseases::DiseaseInfoType.where(parent_id: nil)
    # .each do |follow|
    #   top_name = follow.name
    #   disease_info_types = Diseases::DiseaseInfoType.where(parent_id: follow.id)

    #   disease_info_types.each do |disease_info_type|
    #     arr = {
    #       id: disease_info_type.id,
    #       name: disease_info_type.name,
    #       has_followed: disease_info_type_ids.include?(disease_info_type.id)
    #     }

    #     if big_hash.keys.include? top_name.to_sym
    #       big_hash[top_name.to_sym] = big_hash[top_name.to_sym] << arr
    #     else
    #       big_hash[top_name.to_sym] = [arr]
    #     end
    #   end
    # end


  end

end
