class AccountsAPI < Grape::API

  params do
    requires :account do
      optional :email, type: String
      optional :username, type: String
      optional :password, type: String
    end
  end
  post :sign_up do
    account = Account.new(declared(params)[:account])
    if account.save
      sign_in account
      present! account
    else
      failure! account
    end
  end

  params do
    requires :account do
      optional :email, type: String
      optional :username, type: String
      optional :password, type: String
    end
  end
  post :sign_in do
    account_params = params[:account] || {}
    sign_in_params = account_params.slice(:email, :username)
    password = account_params[:password]
    account = Account.find_for_database_authentication(sign_in_params)
    unvalid_account! unless account && account.valid_password?(password)
    sign_in account
    present! account
  end

  params do
    requires :account do
      optional :uid, type: String
      optional :access_token, type: String
    end
  end
  namespace :sign_in do

    post :weibo do
      account_params = params[:account] || {}
      unauthorized! unless account_params[:uid]
      json = RestClient.post "https://api.weibo.com/oauth2/get_token_info",
        access_token: account_params[:access_token]
      json = JSON.parse json
      puts json, account_params
      unauthorized! unless json["uid"].to_s == account_params[:uid]
      account = Account.find_for_database_authentication(provider: "weibo", 
        uid: account_params[:uid])
      if account
        sign_in account
        present! account
      else
        json = RestClient.get "https://api.weibo.com/2/users/show.json"\
          "?access_token=#{account_params[:access_token]}"\
          "&uid=#{account_params[:uid]}"
        json = JSON.parse json
        account = Account.new(provider: "weibo", uid: account_params[:uid])
        account.username = json["screen_name"]
        account.email = "#{account_params[:uid]}@weibo.com"
        account.password = Devise.friendly_token
        if account.save
          sign_in account
          present! account
        else
          failure! account
        end
      end
    end
    
    post :qqconnect do
      account_params = params[:account] || {}
      unauthorized! unless account_params[:uid]
      json = RestClient.get "https://graph.qq.com/oauth2.0/me"\
        "?access_token=#{account_params[:access_token]}"
      json = JSON.parse json.gsub(/^callback\(|\);$/, "")
      unauthorized! unless json["openid"] == account_params[:uid]
      account = Account.find_for_database_authentication(provider: "qqconnect", 
        uid: account_params[:uid])
      if account
        sign_in account
        present! account
      else
        json = RestClient.get "https://graph.qq.com/user/get_user_info"\
          "?access_token=#{account_params[:access_token]}"\
          "&oauth_consumer_key=101165275"\
          "&openid=#{account_params[:uid]}"
        json = JSON.parse json
        account = Account.new(provider: "qqconnect", uid: account_params[:uid])
        account.username = json["nickname"]
        account.email = "#{account_params[:uid]}@qqconnect.com"
        account.password = Devise.friendly_token
        if account.save
          sign_in account
          present! account
        else
          failure! account
        end
      end
    end
    
  end

  delete :sign_out do
    sign_out account
  end

end