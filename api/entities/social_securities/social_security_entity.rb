class SocialSecurities::SocialSecurityEntity < ApplicationEntity

  expose :id, :name, :url

  expose :type do |object, options|
    "link"
  end

end
