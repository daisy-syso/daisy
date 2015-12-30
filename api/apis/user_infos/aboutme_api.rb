class UserInfos::AboutmeAPI < Grape::API

  namespace :aboutme do
    get do
      user = current_user!
      present user, with: ::AccountEntity
    end
  end
end
