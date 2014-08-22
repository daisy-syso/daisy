module SocialSecurities
  class SocialSecurityEntity < Grape::Entity
    expose :id

    expose :name do |object, options|
      object.city.name
    end

    expose :link do |object, options|
      object.url
    end

  end
end
