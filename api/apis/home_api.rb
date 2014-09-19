class HomeAPI < Grape::API

  get :home do
    {
      buttons: [{
        title: "医院大全",
        link: "#/list/hospitals/hospitals",
        icon: "images/icons/1-1.gif"
      }, {
        title: "疾病查询",
        link: "#/list/diseases/diseases",
        icon: "images/icons/1-2.gif"
      }, {
        title: "找医生",
        link: "#/list/hospitals/doctors",
        icon: "images/icons/1-3.gif"
      }, {
        title: "手机挂号",
        link: "#/list/hospitals/registrations",
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
        link: "#/list/examinations/examinations",
        icon: "images/icons/2-3.gif"
      }, {
        title: "养老服务",
        link: "#/list/eldercares/nursing_rooms",
        icon: "images/icons/2-5.gif"
      }, {
        title: "月子中心",
        link: "#/list/maternals/confinement_centers",
        icon: "images/icons/2-10.gif"
      }, {
        title: "母婴会馆",
        link: "#/list/maternals/maternal_halls",
        icon: "images/icons/2-11.gif"
      }, {
        title: "返利优惠",
        link: "#/list/coupons/coupons",
        icon: "images/icons/1-11.gif"
      }]
    }
  end

end