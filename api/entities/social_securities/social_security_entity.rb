class SocialSecurities::SocialSecurityEntity < ApplicationEntity

  expose :id

  expose :name do |object, options|
    object.city.name rescue "未知"
  end

  expose :url, as: :link

  expose :type do |object, options|
    "social_securities/social_securities"
  end

end
