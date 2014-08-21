class AccountEntity < Grape::Entity
  expose :id, :email, :username, :authentication_token

end
