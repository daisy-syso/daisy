class SocialSecurities::SocialSecurityEntity < ApplicationEntity

  expose :id

  expose :name do |object, options|
    object.city.name
  end

  expose :url, as: :link

end
