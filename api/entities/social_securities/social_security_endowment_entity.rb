class SocialSecurities::SocialSecurityEndowmentEntity < ApplicationEntity

  expose :id, :url

  expose :name do |object, options|
    if object.city
      object.city.name
    else
      object.province.name
    end rescue "未知"
  end

  expose :type do |object, options|
    "link"
  end

end
