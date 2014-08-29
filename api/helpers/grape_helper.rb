module GrapeHelper

  def apply_scopes! resource
    resource = apply_scopes resource
    if params[:page]
      resource = resource.paginate(page: params[:page],
        per_page: params[:per_page] || 10)
      no_more_record! if resource.out_of_bounds?
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
    warden.user(scope: :account).tap do |user|
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

AppConfig = {
  home: {
    buttons: [{
      title: "医院大全",
      link: "#/list/hospitals/hospitals",
      icon: "images/icons/1-1.gif"
    }, {
      title: "疾病查询",
      link: "#/list/drugs/diseases",
      icon: "images/icons/1-2.gif"
    }, {
      title: "找医生",
      link: "#/list/hospitals/doctors",
      icon: "images/icons/1-3.gif"
    }, {
      title: "手机挂号",
      link: "#/home",
      icon: "images/icons/1-4.gif"
    }, {
      title: "药品大全",
      link: "#/list/drugs/drugs",
      icon: "images/icons/1-5.gif"
    }, {
      title: "身边药房",
      link: "#/list/drugs/drugstores",
      icon: "images/icons/1-6.gif"
    }, {
      title: "医保查询",
      link: "#/list/social_securities/social_securities",
      icon: "images/icons/1-7.gif"
    }, {
      title: "价格搜索",
      link: "#/menu/price_search",
      icon: "images/icons/1-8.gif"
    }, {
      title: "热门专科",
      link: "#/list/hospitals/top_specialists",
      icon: "images/icons/1-9.gif"
    }, {
      title: "热门诊所",
      link: "#/home",
      icon: "images/icons/1-10.gif"
    }, {
      title: "全国体检",
      link: "#/list/hospitals/examinations",
      icon: "images/icons/2-3.gif"
    }, {
      title: "养老服务",
      link: "#/list/hospitals/nursing_rooms",
      icon: "images/icons/2-5.gif"
    }, {
      title: "返利优惠",
      link: "#/home",
      icon: "images/icons/1-11.gif"
    }]
  }
}