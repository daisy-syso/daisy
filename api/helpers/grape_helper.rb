module GrapeHelper
  def failure! resource
    error! resource.errors.full_messages.first, 422
  end

  def present! resource, options = {}
    if resource
      options[:with] ||= get_entity_class(resource)

      resource = paginate(resource).to_a

      present options[:meta]
      present :data, resource, options
      
    else
      error! "404 Record Not Found", 404
    end
  end

  def get_entity_class resource
    case resource
    when ActiveRecord::Base
      resource_class = resource.class
    when ActiveRecord::Relation
      resource_class = resource.klass
    when Array
      resource_class = resource.to_a.first.class
    end

    entity_class = nil
    unless entity_class or resource_class == ActiveRecord::Base
      entity_class = "#{resource_class.name}Entity".try :constantize
      resource_class = resource_class.superclass
    end
    entity_class

  end

  def warden
    env['warden']
  end

  def authenticated
    return true if warden.authenticated?
    params[:access_token] && @account = Account.find_by(authentication_token: params[:access_token])
  end

  def current_account
    warden.account || @account
  end

  def paginate resource
    resource.paginate(page: params[:page], per_page: params[:per_page] || 10)
  end

  def filter_cities_cached
    # Rails.cache.fetch([:api, :filter, :cities]) do
      Province.includes(:cities).map do |province|
        children = province.cities.map do |city|
          { title: city.name, params: { city: city.id } }
        end
        { title: province.name, children: children }
      end
    # end
  end
end
