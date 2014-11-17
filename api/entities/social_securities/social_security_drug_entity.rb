class SocialSecurities::SocialSecurityDrugEntity < ApplicationEntity

  expose :id, :url

  expose :name do |object, options|
    object.city.name rescue "未知"
  end

  expose :type do |object, options|
    "link"
  end

end
