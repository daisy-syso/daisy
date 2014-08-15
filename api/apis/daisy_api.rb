class DaisyAPI < Grape::API

  post :login do
    p params
    UserSession.create params
  end

end