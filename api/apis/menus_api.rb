class MenusAPI < Grape::API

  get :price_search do
    menu = {
      title: "价格搜索",
      data: [{
        title: "药品",
        link: "#/list/price_search/drugs",
      }, {
        title: "整容",
        link: "#/list/price_search/shaping_items",
      }]
    }
    present menu
  end

end