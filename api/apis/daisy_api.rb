class DaisyAPI < Grape::API
  format :json

  rescue_from :all, :backtrace => true
  error_formatter :json, ErrorFormatter

  helpers GrapeHelper

  mount AccountsAPI
  mount FavoritesAPI
  mount FiltersAPI

  mount Hospitals::HospitalsAPI
  mount Hospitals::DoctorsAPI

  mount Drugs::DrugsAPI
  
  mount NetInfos::HotSearchKeywordsAPI

  get :config do
    AppConfig
  end

  route :any, '*path' do
    not_found!
  end

end

AppConfig = {
  home: {
    buttons: [{
      title: "医院大全",
      link: "#/list/hospitals",
      icon: "images/icons/1-1.gif"
    }, {
      title: "疾病查询",
      link: "#/home",
      icon: "images/icons/1-2.gif"
    }, {
      title: "找医生",
      link: "#/list/doctors",
      icon: "images/icons/1-3.gif"
    }, {
      title: "手机挂号",
      link: "#/home",
      icon: "images/icons/1-4.gif"
    }, {
      title: "药品大全",
      link: "#/list/drugs",
      icon: "images/icons/1-5.gif"
    }, {
      title: "身边药房",
      link: "#/list/drugstores",
      icon: "images/icons/1-6.gif"
    }, {
      title: "医保查询",
      link: "#/list/social_securities",
      icon: "images/icons/1-7.gif"
    }, {
      title: "价格搜索",
      link: "#/home",
      icon: "images/icons/1-8.gif"
    }, {
      title: "热门专科",
      link: "#/home",
      icon: "images/icons/1-9.gif"
    }, {
      title: "热门诊所",
      link: "#/home",
      icon: "images/icons/1-10.gif"
    }, {
      title: "返利优惠",
      link: "#/home",
      icon: "images/icons/1-11.gif"
    }]
  }
}