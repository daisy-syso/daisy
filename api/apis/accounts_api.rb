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
    unauthorized! unless account && account.valid_password?(password)
    sign_in account
    present! account
  end

  delete :sign_out do
    sign_out account
  end

end