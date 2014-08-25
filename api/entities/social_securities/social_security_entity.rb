module SocialSecurities
  class SocialSecurityEntity < Grape::Entity
    expose :id

    expose :name do |object, options|
      object.city.name
    end

    expose :link do |object, options|
      object.url
    end

    expose :type do |object, options|
      "social_security"
    end

  end
end
