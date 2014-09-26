class SocialSecurities::SocialSecurityEndowmentEntity < ApplicationEntity

  expose :id

  expose :name do |object, options|
    if object.city
      object.city.name
    else
      object.province.name
    end rescue "未知"
  end

  expose :url, as: :link

  expose :type do |object, options|
    "social_securities/social_securities"
  end

end
