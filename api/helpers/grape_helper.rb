module GrapeHelper

  def apply_scopes! resource
    resource = apply_scopes resource
    if params[:page]
      resource = resource.page(params[:page])
      resource = resource.per(params[:per] || 10)
    end
    resource
  end

  def failure! resource
    error! resource.errors.full_messages, 422
  end

  def present! resource, options = {}
    if resource
      options[:with] ||= get_entity_class(resource)

      if resource.respond_to? :to_a
        resource = resource.to_a 
        # record_not_found! if resource.empty?
      end
      
      present options[:meta]
      present :data, resource, options
      present :fin, true if resource.count < (params[:per] || 10)
      
    else
      record_not_found!
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

  def no_more_record!
    error! "404 No More Record", 404
  end

  def record_not_found!
    error! "404 Record Not Found", 404
  end

  def not_found!
    error! "404 Not Found", 404
  end

  def unauthorized!
    error! "401 Unauthorized", 401
  end

  def warden
    env['warden']
  end

  def authenticated
    return true if warden.authenticated?
  end

  def current_user
    warden.user(scope: :account)
  end

  def current_user!
    current_user.tap do |user|
      unauthorized! unless user
    end
  end

  def sign_in account
    warden.set_user(account, scope: :account)
  end

  def sign_out
    warden.logout(:account)
  end

end
