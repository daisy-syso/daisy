#= require angular/angular
#= require angular-animate/angular-animate
#= require angular-route/angular-route
#= require angular-touch/angular-touch
#= require angular-carousel/dist/angular-carousel
#= require angular-loading-bar/build/loading-bar
#= require angular-bootstrap/ui-bootstrap-tpls
#= require ionic/release/js/ionic.bundle
#= require lodash/lodash.min
#= require angular-google-maps/dist/angular-google-maps.min


angular.module 'DaisyApp', [
  "ngAnimate"
  "ngRoute"
  "ngTouch"
  "angular-local-storage"
  "angular-carousel"
  'ui.bootstrap'
  'ionic'
  'uiGmapgoogle-maps'
]

.config [
  '$routeProvider'
  ($routeProvider) ->

    # 主页
    $routeProvider.when '/home',
      templateUrl: "templates/home.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$ionicSlideBoxDelegate'
        ($rootScope, $scope, $loader, $ionicSlideBoxDelegate) ->
          $scope.slides = [
              {image: "images/adv/1581.jpg", text: "image1"},
              {image: "images/adv/1632.jpg", text: "image2"},
              {image: "images/adv/1610.jpg", text: "image3"},
              {image: "images/adv/1596.jpg", text: "image4"}
            ]
          $scope.slide_infos = [
            {image: "images/adv/img02.jpg", text: "image1"},
            {image: "images/adv/img03.jpg", text: "image2"},
            {image: "images/adv/img04.jpg", text: "image3"},
            {image: "images/adv/img05.jpg", text: "image4"}
          ]
          unless $rootScope.homeData
            $loader.get("/api/home.json")
              .success (data) ->
                $rootScope.homeData = data
          $loader.get("/api/infors/apps/examples")
            .success (data) ->
              $rootScope.apps = data.apps
          $rootScope.$watch "city", (value) ->
            length = value?.title?.length || 2
            $rootScope.searchLeft = "#{20*length+40}px"
      ]
    # ============== 团购 ===========
    # 团购优惠
    $routeProvider.when '/privileges/hospitals',
      templateUrl: "templates/privileges/hospitals/index.html"
      controller: [
        '$scope', '$loader', '$routeParams', '$location', '$rootScope'
        ($scope, $loader, $routeParams, $location, $rootScope) ->
          $scope.page = 1
          params = angular.extend { page: $scope.page }, $location.search()
          url = "/api/privileges/hospitals"
          $loader.get(url, params: params)
            .success (data) ->
              $scope.moreData = true unless data.data.length < 25
              $scope.data = data
          $scope.type = "privileges/hospitals"
          $scope.redirectTo = (type, params) ->
            # $scope.loadData(type, params)
            $location.path("list/#{type}")
            $location.path(type) if $rootScope.newRedirectolink.indexOf(type) >= 0
            params = angular.extend $location.search(), params
            $location.search(params)
            $location.replace()
            # $location.keep = false
          $scope.loadMore = () ->
            params = angular.extend { page: $scope.page += 1 }, $location.search()
            $loader.get(url, params: params)
              .success (data) ->
                $scope.moreData = false if  data.data.length < 25
                $scope.data['data'] = $scope.data['data'].concat data['data']
      ]

    $routeProvider.when '/privileges/hospital_types/hospital_charges/hospital_onsales/:id',
      templateUrl: "templates/privileges/hospitals/hospital_onsale.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams', '$animate'
        ($rootScope, $scope, $loader, $routeParams, $animate) ->
          $rootScope.footerHide = true
          $scope.title = "医疗团购"
          $loader.get("/api/privileges/hospitals/hospital_types/hospital_charges/hospital_onsales/#{$routeParams.id}")
            .success (data) ->
              $scope.data = data.data
      ]

    #  疾病保险
    $routeProvider.when '/privileges/insurances',
      templateUrl: "templates/privileges/insurances/index.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams','$location'
        ($rootScope, $scope, $loader, $routeParams, $location) ->
          $scope.page = 1
          params = angular.extend { page: $scope.page }, $location.search()
          url = "/api/privileges/insurances"
          $scope.title = "疾病保险"
          $loader.get(url, params: params)
            .success (data) ->
              $scope.moreData = true unless data.data.length < 25
              $scope.data = data
          $scope.type = "privileges/insurances"
          console.log($rootScope.newRedirectolink.indexOf($scope.type))
          $scope.redirectTo = (type, params) ->
            # $scope.loadData(type, params)
            $location.path("list/#{type}")
            $location.path(type) if $rootScope.newRedirectolink.indexOf(type) >= 0
            params = angular.extend $location.search(), params
            $location.search(params)
            $location.replace()
          $scope.loadMore = () ->
            params = angular.extend { page: $scope.page += 1 }, $location.search()
            $loader.get(url, params: params)
              .success (data) ->
                $scope.moreData = false if  data.data.length < 25
                $scope.data['data'] = $scope.data['data'].concat data['data']

      ]

    $routeProvider.when '/privileges/insurances/:id',
      templateUrl: 'templates/privileges/insurances/insurance.html'
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams','$location'
        ($rootScope, $scope, $loader, $routeParams, $location) ->
          $rootScope.footerHide = true
          $loader.get("/api/privileges/insurances/#{$routeParams.id}")
            .success (data) ->
              $scope.data = data.data
      ]

    # 母婴亲子

    $routeProvider.when '/privileges/maternals/:type',
      templateUrl: (routeParams) ->
        "templates/privileges/maternals/#{routeParams.type}/index.html"
      controller: [
        '$scope', '$loader', '$routeParams', '$location', '$rootScope'
        ($scope, $loader, $routeParams, $location, $rootScope) ->
          $scope.page = 1
          params = angular.extend { page: $scope.page }, $location.search()
          # url = "/api/privileges/hospitals"

          url = "/api/maternals/#{$routeParams.type}"
          $loader.get(url, params: params)
            .success (data) ->
              $scope.moreData = true unless data.data.length < 25
              $scope.data = data
          $scope.type = "privileges/maternals/#{$routeParams.type}"
          $scope.redirectTo = (type, params) ->
            $location.path("list/#{type}")
            $location.path(type) if $rootScope.newRedirectolink.indexOf(type) >= 0
            params = angular.extend params, $location.search()
            $location.search(params)
            $location.replace()
            # $location.keep = false
          $scope.loadMore = () ->
            params = angular.extend { page: $scope.page += 1 }, $location.search()
            $loader.get(url, params: params)
              .success (data) ->
                $scope.moreData = false if  data.data.length < 25
                $scope.data['data'] = $scope.data['data'].concat data['data']
      ]

    $routeProvider.when '/privileges/maternals/:type/:id',
      templateUrl: (routeParams) ->
        "templates/privileges/maternals/#{routeParams.type}/show.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams','$location'
        ($rootScope, $scope, $loader, $routeParams, $location) ->
          $rootScope.footerHide = true
          $loader.get("/api/maternals/#{$routeParams.type}/#{$routeParams.id}")
            .success (data) ->
              $scope.data = data.data
      ]
      # 最新优惠
    $routeProvider.when '/privileges/newest',
      templateUrl: "templates/privileges/newest/index.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams','$location'
        ($rootScope, $scope, $loader, $routeParams, $location) ->
          url = "/api/privileges/newest"
          console.log(url)
          $scope.page = 1
          params = angular.extend { page: $scope.page }, $location.search()
          $loader.get(url, params: params)
            .success (data) ->
              $scope.moreData = true unless data.data.length < 25
              $scope.data = data
          $scope.type = "privileges/newest"
          $scope.redirectTo = (type, params) ->
            # $scope.loadData(type, params)
            console.log(params)
            $location.path("list/#{type}")
            $location.path(type) if $rootScope.newRedirectolink.indexOf(type) >= 0
            params = angular.extend $location.search(), params
            $location.search(params)
            $location.replace()
            # $location.keep = false
          $scope.loadMore = () ->
            params = angular.extend { page: $scope.page += 1 }, $location.search()
            $loader.get(url, params: params)
              .success (data) ->
                $scope.moreData = false if  data.data.length < 25
                $scope.data['data'] = $scope.data['data'].concat data['data']

      ]

    $routeProvider.when '/privileges/newest/:id',
      templateUrl: "templates/privileges/newest/hospital_onsale.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams', '$animate'
        ($rootScope, $scope, $loader, $routeParams, $animate) ->
          $rootScope.footerHide = true
          $scope.title = "最新优惠"
          $loader.get("/api/privileges/newest/#{$routeParams.id}")
            .success (data) ->
              $scope.data = data.data
      ]
    # ===================团购 end=======================================

    $routeProvider.when '/detail/drugstores/:store_id/drugs/:drug_id',
      templateUrl: "templates/details/drugs/drugstore.html"
      controller: [
        '$rootScope', '$scope', '$loader', '$routeParams','$location'
        ($rootScope, $scope, $loader, $routeParams, $location) ->
          $loader.get("/api/drugs/drugstores/#{$routeParams.store_id}/drugs/#{$routeParams.drug_id}")
            .success (data) ->
              console.log("drugs=============")
              $scope.data = data

      ]

    # $routeProvider.when '/details/insurances/insurances/:id'

    # app分类展示页面
    $routeProvider.when '/infors/:type',
      templateUrl: (routeParams) ->
        "templates/#{routeParams.type}_infor.html"
      controller:[
        '$rootScope', '$scope', '$loader', '$routeParams', '$animate'
        ($rootScope, $scope, $loader, $routeParams, $animate) ->
          $scope.start = [0, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
          $scope.swipeLeft = (i, l) ->
            console.log("swipe left")
            $scope.start[i] += 1 unless $scope.start[i] + 5 == l || l <= 5
            console.log($scope.start[i])

          $scope.swipeRight = (i) ->
            console.log("swipe right")
            $scope.start[i] += -1  unless $scope.start[i] == 0

          $loader.get("/api/infors/#{$routeParams.type}.json")
            .success (data) ->
              $scope.data = data
      ]

    $routeProvider.when '/infors/nav/:id',
      templateUrl: "templates/infors.html"
      controller:[
        '$rootScope', '$scope', '$loader', '$routeParams'
        ($rootScope, $scope, $loader, $routeParams) ->
          $loader.get("/api/infors/nav/#{$routeParams.id}.json")
            .success (data) ->
              $scope.infors = data
      ]

    # 同类别app展示页面
    $routeProvider.when '/infors/app_types/:id',
    templateUrl: "templates/informations/apps/more.html"
    controller:[
      '$rootScope', '$scope', '$loader', '$routeParams'
      ($rootScope, $scope, $loader, $routeParams) ->
        $loader.get("/api/infors/apps/#{$routeParams.id}.json")
          .success (data) ->
            $scope.infors = data
    ]

    $routeProvider.when '/login/:redirectToPath*',
      templateUrl: "templates/login.html",
      controller: [
        '$scope', '$rootScope', '$routeParams'
        ($scope, $rootScope, $routeParams) ->
          $scope.redirectToPath = $routeParams.redirectToPath
          $rootScope.redirectTo($scope.redirectToPath) if $rootScope.account
      ]

    $routeProvider.when '/register/:redirectToPath*',
      templateUrl: "templates/register.html"

    $routeProvider.when '/retrieve',  templateUrl: "templates/retrieve.html"
    $routeProvider.when '/favorites', templateUrl: "templates/favorites.html"
    $routeProvider.when '/search',    templateUrl: "templates/search.html"
    $routeProvider.when '/healthInformation',
      templateUrl: "templates/health_information.html"
      controller:[
        '$scope', '$routeParams', '$loader', '$location', "$ionicScrollDelegate", "$timeout"
        ($scope, $routeParams, $loader, $location, $ionicScrollDelegate, $timeout) ->
          $scope.infor_items = {}
          $scope.afterHeight = false
          itemShowWithPicture = ["健身减肥","美食","养身", "天天护理"]

          $scope.showChildreninfors = (parent_id, children_id) ->
            url = "/api/infors/health_infors.json?type=#{children_id}"
            $loader.get(url)
              .success (data) ->
                $scope.infor_items["type_#{parent_id}"].latest_informations =  data.data[0].latest_informations

          $scope.gotoCategory = (id) ->
            document.getElementById(id).scrollIntoView()
            $scope.afterHeight = true
            $timeout( () ->
               scroll = document.querySelector('.scroll-content')
               console.info(scroll.scrollTop);
               if (scroll)
                scroll.scrollTop = 0
            ,0,false)

          $scope.itemWithPicture2 = (name) ->
            if name in itemShowWithPicture then true

          $scope.loadMore = (type) ->
            if $scope["#{type}_page"]
              page = $scope["#{type}_page"] +=1
            else
              page = $scope["#{type}_page"] = 2
            url = if type
              "/api/infors/health_infors.json?page=#{page}&type=#{type}"
            else
              "/api/infors/health_infors.json"
            $loader.get(url)
            .success (data) ->
              if !type
                $scope.health_infors = data;
                for infor_item in data.data
                  $scope.infor_items["type_#{infor_item.id}"] = infor_item
              else
                $scope.infor_items["type_#{data.data[0].id}"].latest_informations = $scope.infor_items["type_#{data.data[0].id}"].latest_informations.concat data.data[0].latest_informations

          $scope.loadMore()
      ]


    $routeProvider.when '/healthInformationDetail',
      templateUrl: "templates/health_information_detail.html"
      controller:[
        '$scope', '$routeParams', '$loader', '$location'
        ($scope, $routeParams, $loader, $location) ->
          $loader.get("/api/infors/health_infors/#{$routeParams.id}.json")
            .success (data) ->
              $scope.health_infor = data.data
          $loader.get("/api/infors/health_infors/#{$routeParams.id}/read.json")
            .success (data) ->
              console.info("log the read");

          $scope.review = () ->
            $location.path("review/Informations::Information/#{$routeParams.id}")
      ]

    $routeProvider.when '/mapNavigation',
      templateUrl: "templates/map_navigation.html"
      controller:[
        '$scope', '$routeParams', '$loader', '$location'
        ($scope, $routeParams, $loader, $location) ->
          # 百度地图API功能
          map = new BMap.Map("allmap")
          map.addControl(new BMap.NavigationControl());        # 添加平移缩放控件
          map.addControl(new BMap.ScaleControl());             # 添加比例尺控件
          map.addControl(new BMap.OverviewMapControl());       # 添加缩略地图
          geolocation = new BMap.Geolocation()
          destinationPoint = new BMap.Point(Number($routeParams.lng),Number($routeParams.lat))
          map.centerAndZoom(destinationPoint,12)

          # get current location
          geolocation.getCurrentPosition (r) ->
            if this.getStatus() == BMAP_STATUS_SUCCESS
              mk = new BMap.Marker(r.point)
              map.addOverlay(mk)
              map.panTo(r.point)
              $scope.currentPoint = r.point
            else
              alert('failed'+this.getStatus());
          ,{enableHighAccuracy: true}

          $scope.transitRoute = () ->
            transit = new BMap.TransitRoute(map, {
              renderOptions: {map: map, panel: "r-result"}
            });
            transit.search($scope.currentPoint, destinationPoint);

          $scope.drivingRoute = () =>
            driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}});
            driving.search($scope.currentPoint, destinationPoint)

          $scope.walkingRoute = () ->
            walking = new BMap.WalkingRoute(map, {renderOptions: {map: map, panel: "r-result", autoViewport: true}});
            walking.search($scope.currentPoint, destinationPoint);
      ]

    $routeProvider.when '/join_league',
      templateUrl: 'templates/join_league.html'
      controller:[
        '$scope', '$routeParams', '$loader', '$location'
        ($scope, $routeParams, $loader, $location) ->
          $scope.form = {}
          $scope.changeType = () ->
            $scope.selected = this.selected
            $scope.currentType = $scope.getApplyTypes()[0]

          $scope.getApplyTypes = () =>
            $scope.apply_types.filter (apply_type) =>
              if apply_type.type == $scope.selected then apply_type

          $scope.submitForm = () =>
            $loader.post("/api/join_applies/join_applies/post_apply.json",{
                email: $scope.form.email
                target_attrs: $scope.form
                target_type: $scope.selected
              }).success (data) ->
                $location.path("/")

          $loader.get("/api/join_applies/join_applies/apply_types.json")
            .success (data) ->
              $scope.currentType = data.apply_types[0]
              $scope.selected = $scope.currentType.type
              $scope.apply_types = data.apply_types

      ]

    $routeProvider.when '/review/:item_type/:item_id',
      templateUrl: "templates/review.html"
      controller:[
        '$scope', '$routeParams', '$loader', '$http'
        ($scope, $routeParams, $loader, $http) ->
          $scope.desc = ""
          $scope.account_id = 12
          $scope.environment = 0
          $scope.service = 0
          $scope.charge = 0
          $scope.technique = 0
          if $routeParams.item_type == "Informations::Information" then $scope.hiddenStar = true
          $scope.submit = () =>
            $http.post("/api/reviews_new/",{
              item_type: $routeParams.item_type || "Drugs::Drug",
              item_id: $routeParams.item_id || 700640,
              desc: $scope.desc,
              account_id: $scope.account_id || 7,
              environment: $scope.environment,
              service: $scope.service,
              charge: $scope.charge,
              technique: $scope.technique
            }).success (data) ->
              window.history.back();
      ]

    $routeProvider.when '/menu/:type',
      templateUrl: "templates/menu.html"
      controller: [
        '$scope', '$routeParams', '$loader'
        ($scope, $routeParams, $loader) ->
          $scope.type = $routeParams.type
          url = "/api/#{$routeParams.type}.json"

          $loader.get(url)
            .success (data) ->
              $scope.data = data
      ]

    detailCtrl = [
      '$scope', '$routeParams', '$loader', '$alert', '$location', '$rootScope', '$anchorScroll'
      ($scope, $routeParams, $loader, $alert, $location, $rootScope, $anchorScroll) ->
        $scope.type = $routeParams.type
        $rootScope.footerHide = true
        if $routeParams.type == "hospitals/hospitals_polyclinic"
          $scope.type = "hospitals/hospitals"
        $scope.id = $routeParams.id

        $scope.array_3 = (a) ->
          new_array = []
          ele = []
          angular.forEach(a, (e, i)->
            if (i+1)%3 == 0
              ele.push(e)
              new_array.push(ele)
              ele = []
            else
              ele.push(e)
          )
          new_array.push(ele) if ele.length < 3 && ele.length > 0
          return new_array

        $scope.params_hospital_rooms = (a) ->
          angular.forEach(a, (e, i)->
            e.doctors = $scope.array_3(e.doctors)
          )
        $scope.goto = (id) ->
          console.log($location.hash())
          $location.hash(id)
          $anchorScroll()
        $scope.params = $location.search()
        $scope.detail_id = $routeParams.detail
        url = "/api/#{$scope.type}/#{$routeParams.id}.json"
        params = angular.extend { onsale_id: $routeParams.onsale_id }, $scope.params
        console.log(params)
        $loader.get(url, params: params)
          .success (data) ->
            $scope.data = data['data']
            $scope.map = { center: { latitude: $scope.data.lat, longitude: $scope.data.lng }, zoom: 8 }
            $scope.params_hospital_rooms($scope.data.hospital_rooms) if $scope.data.hospital_rooms

    ]

    drugDetailCtrl = [
      '$scope', '$routeParams', '$loader', '$alert', '$location'
      ($scope, $routeParams, $loader, $alert, $location) ->
        url = "/api/drugs/drugs/#{$routeParams.id}/#{$routeParams.manufactory_id}"

        $scope.review = () ->
          $location.path("review/Drugs::Drug/#{$routeParams.id}")

        $loader.get(url)
          .success (data) ->
            $scope.data = data
            $scope.data.name = "药品报价"
    ]

    symptomsDetailCtrl = [
      '$scope', '$routeParams', '$loader', '$alert', '$location'
      ($scope, $routeParams, $loader, $alert, $location) ->
        url = "/api/symptoms/symptoms/#{$routeParams.id}"

        $loader.get(url)
          .success (data) ->
            $scope.symptoms = data.data
    ]

    examinationsDetailCtrl = [
      '$scope', '$routeParams', '$loader', '$alert', '$location'
      ($scope, $routeParams, $loader, $alert, $location) ->
        url = "/api/examinations/examinations/#{$routeParams.id}"

        $loader.get(url)
          .success (data) ->
            $scope.data = data.data
    ]

    $routeProvider.when '/order/:type*/:id',
      templateUrl: "templates/order.html"
      controller: detailCtrl

    $routeProvider.when '/detail/examinations/examinations/:id',
      templateUrl: 'templates/details/examinations/examination_item.html'
      controller: examinationsDetailCtrl

    $routeProvider.when '/detail/drugs/drugs/:id/:manufactory_id',
      templateUrl: "templates/details/drugs/drugs.html"
      controller: drugDetailCtrl

    $routeProvider.when '/detail/symptoms/symptoms/:id',
      templateUrl: "templates/details/symptoms/symptom_item.html"
      controller: symptomsDetailCtrl

    # $routeProvider.when '/detail/strategies/hospital_charge',
    #   templateUrl: "templates/details/strategies/hospital_charge.html"
    #   controller: [
    #     '$scope', '$loader', '$route', '$location', '$routeParams'
    #     ($scope, $loader, $route, $location, $routeParams) ->
    #       params = $location.search()
    #       console.log(params)
    #       $loader.get(url, params: params)
    #         .success (data) ->
    #           $scope.data = data
    #   ]


    $routeProvider.when '/detail/:type*/:id',
      templateUrl: (routeParams) ->
        if routeParams.detail
          "templates/details/display.html"
        else if routeParams.type == "hospitals"
          "templates/details/#{routeParams.type}/#{routeParams.type}.html"
        else if routeParams.type == "strategies"
          "templates/details/strategies/hospital_charge.html"
        else
          "templates/details/#{routeParams.type}.html"
      controller: detailCtrl
      reloadOnSearch: false

    listCtrl = [
      '$scope', '$loader', '$route', '$location', '$routeParams'
      ($scope, $loader, $route, $location, $routeParams) ->
        $scope.loadData = (type, params) ->
          $scope.type = type
          $scope.params = params
          # $alert.info($scope.listUrl)
          url = "/api/#{type}.json"
          page = $scope.page = 1
          params = angular.extend { page: page }, params
          $loader.get(url, params: params)
            .success (data) ->
              $scope.data = data

        $scope.redirectTo = (type, params) ->
          $scope.loadData(type, params)

          $location.path("list/#{type}")
          params = angular.extend $location.search(), params
          $location.search(params)
          $location.replace()
          $location.keep = false

        $scope.loadData($route.current.params.type, $location.search())
        $scope.nofilters = true if $routeParams.type == "menus"
        $scope.loadMore = () ->
          url = "/api/#{$scope.type}.json"
          page = $scope.page += 1
          params = angular.extend { page: page }, $scope.params
          $loader.get(url, params: params)
            .success (data) ->
              $scope.data['fin'] = data['fin']
              $scope.data['data'] = $scope.data['data'].concat data['data']

    ]

    DrugListCtrl = [
      '$scope', '$loader', '$route', '$location', '$routeParams', '$ionicLoading'
      ($scope, $loader, $route, $location, $routeParams, $ionicLoading ) ->
        # url = if $routeParams.name
        #   "/api/drugs/drugs/drug_manufactories.json"
        # else
        #   "/api/drugs/drugs.json"
        url = "/api/drugs/drugs.json"
        $scope.withTitle = $routeParams.name
        $scope.moreData = true

        $scope.drugUrl = (drug) ->
          if $routeParams.name
            "#/detail/drugs/drugs/#{ drug.drug_id }/#{drug.manufactory_id}"
          else
            "#/list/drugs/drugs?name=#{ drug.name } "

        $scope.linkToManufactory = (id) ->
          $location.path("detail/drugs/manufactories/#{id}")
          $location.replace()

        $scope.linkToDrugDetail = (id) ->
          $location.path("/detail/drugs/drugs/#{id}")
          $location.replace()

        $scope.loadData = (type, params) =>
          $scope.type = "drugs/drugs"
          $scope.params = params
          # $alert.info($scope.listUrl)
          page = $scope.page = 1
          params = angular.extend { page: page }, params
          # $ionicLoading.show(
          #   template: '<ion-spinner class="spinner-wighte"></ion-spinner>',
          #   noBackdrop: true
          # )
          $('#loading_div').show()
          $loader.get(url, params: params)
            .success (data) =>
              # if data.drugs.length < 1  then  $scope.moreData = false
              # $scope.drugs = data.drugs
              $scope.moreData = false if  data.data.length < 25
              $scope.data = data
              # $ionicLoading.hide();
              $('#loading_div').hide();

        $scope.loadData($route.current.params.type, $location.search())
        $scope.loadMore = () ->
          page = $scope.page += 1
          params = angular.extend { page: page }, $scope.params
          $ionicLoading.show({
            template: '<ion-spinner class="spinner-energized"></ion-spinner>'
          });
          $loader.get(url, params: params)
            .success (data) ->
              # if data.drugs.length < 1
              #   $scope.moreData = false
              # else
              #   # $scope.drugs = $scope.drugs.concat data.drugs
              if data.data.length < 1
                $scope.moreData = false
              else
                $scope.data.data = $scope.data.data.concat data.data
              $ionicLoading.hide();

        $scope.redirectTo = (type, params) ->
          $scope.loadData(type, params)
          $location.path("list/#{type}")
          $location.search(params)
          $location.replace()
          $location.keep = false

    ]

    SymptomsListCtrl = [
      '$scope', '$loader', '$route', '$location', '$routeParams'
      ($scope, $loader, $route, $location, $routeParams) ->
        $scope.moreData = true
        $('#loading_div').show()
        $scope.getImageUrl = (symptom) =>
          switch symptom.name
            when "头部"
              "images/body-regions/brain.png"
            when "颈部"
              "images/body-regions/neck.png"
            when "胸部"
              "images/body-regions/chest.png"
            when "腹部"
              "images/body-regions/abdomen.png"
            when "腰部"
              "images/body-regions/waist.png"
            when "臀部"
              "images/body-regions/buttocks.png"
            when "上肢"
              "images/body-regions/upper-limbs.png"
            when "下肢"
              "images/body-regions/lower-limbs.png"
            when "骨"
              "images/body-regions/bone.png"
            when "女性生殖"
              "images/body-regions/female-reprodution.png"
            when "男性生殖"
              "images/body-regions/male-reproduction.png"
            when "全身"
              "images/body-regions/body.png"
            when "心理"
              "images/body-regions/mental.png"
            when "背部"
              "images/body-regions/back.png"
            when "其他"
              "images/body-regions/others.png"
            when "会阴部"
              "images/body-regions/perineum.png"
            when "盆腔"
              "images/body-regions/pelvic-cavity.png"

        $scope.getCommentSymtoms = (symptom) =>
          symptom.symptoms.slice(0, 3)

        url = "/api/symptoms/symptoms"
        $scope.loadData = (type, params) =>
          $scope.type = type
          $scope.params = params
          # $alert.info($scope.listUrl)
          page = $scope.page = 1
          params = angular.extend { page: page }, params
          $loader.get(url, params: params)
            .success (data) =>
              $('#loading_div').hide();
              $scope.data = data

        $scope.loadData($route.current.params.type, $location.search())
        $scope.loadMore = () ->
          page = $scope.page += 1
          params = angular.extend { page: page }, $scope.params
          $loader.get(url, params: params)
            .success (data) ->
              if data.symptoms.length < 1
                $scope.moreData = false
              else
                $scope.symptoms = $scope.symptoms.concat data.symptoms
    ]

    ExaminationsListCtrl = [
      '$scope', '$loader', '$route', '$location', '$routeParams'
      ($scope, $loader, $route, $location, $routeParams) ->
        url = "/api/examinations/examinations"
        $scope.moreData = true
        $scope.loadData = (type, params) =>
          $scope.type = type
          $scope.params = params
          page = $scope.page = 1
          params = angular.extend { page: page }, params
          $loader.get(url, params: params)
            .success (data) =>
              $scope.moreData = false if  data.data.length < 25
              $scope.data = data

        $scope.loadData($route.current.params.type, $location.search())
        $scope.loadMore = () ->
          page = $scope.page += 1
          params = angular.extend { page: page }, $scope.params
          $loader.get(url, params: params)
            .success (data) ->
              if data.data.length < 1
                $scope.moreData = false
              else
                $scope.data = $scope.data.concat data.data
    ]

    $routeProvider.when '/list/manufactories/manufactories',
      templateUrl: 'templates/lists/manufactories.html'
      controller: []

    $routeProvider.when '/list/examinations/examinations',
      templateUrl: 'templates/examinations_list.html'
      controller: ExaminationsListCtrl

    $routeProvider.when '/list/symptoms/symptoms',
      templateUrl: 'templates/symptoms_list.html'
      controller: SymptomsListCtrl

    $routeProvider.when '/list/drugs/drugs',
      # templateUrl: "templates/drugs_list.html"
      templateUrl: (routeParams) ->
        if routeParams.drug
          "templates/lists/drugs/drug.html"
        else
          "templates/lists/drugs/drugs_list.html"
      controller: DrugListCtrl
      reloadOnSearch: true

    $routeProvider.when '/list/:type*',
      templateUrl: (routeParams) ->
        # console.log("templates/#{routeParams.template || "list"}.html")
        "templates/#{routeParams.template1 || 'list'}.html"
      controller: listCtrl
      reloadOnSearch: true

    $routeProvider.when '/search/:label',
      templateUrl: "templates/list.html"
      controller: [
        '$scope', '$routeParams', '$localStorage', '$loader', '$location'
        ($scope, $routeParams, $localStorage, $loader, $location) ->
          label = $routeParams.label
          # query = $routeParams.query
          query = $location.search()['query']
          searchHistory = $localStorage.get("searchHistory")
            .filter (word) -> word != query
          # searchHistory.unshift "#{label}/#{query}"
          searchHistory.unshift {url: "#{label}/#{query}", keyword: "#{query}"}
          page = $scope.page = 1
          $scope.nofilters = true
          $localStorage.set("searchHistory", searchHistory)
          $scope.params = angular.extend { label: label, query: query }, $scope.params
          console.log($scope.params)

          $loader.get("/api/search.json", params: $scope.params)
            .success (data) ->
              $scope.data = data

          $scope.loadMore = () ->
            url = "/api/search.json"
            page = $scope.page += 1
            params = angular.extend { page: page }, $scope.params
            console.log($scope.params)
            $loader.get(url, params: params)
              .success (data) ->
                $scope.data['fin'] = data['fin']
                $scope.data['data'] = $scope.data['data'].concat data['data']
      ]

    $routeProvider.when '/deal/order',
      templateUrl: "templates/deal/order.html"
      controller: [
        '$scope', '$rootScope', '$routeParams', '$localStorage', '$loader', '$location'
        ($scope, $rootScope, $routeParams, $localStorage, $loader, $location) ->
          $scope.title = "提交订单"
          $rootScope.footerHide = true
          $scope.count = 1
          $scope.changeCount = (type) ->
            if type == "minus" and $scope.count > 1
              $scope.count -= 1
            else if type == "plus"
              $scope.count += 1



      ]

    $routeProvider.otherwise redirectTo: '/home'
]

#  谷歌地图api 配置
.config [
  'uiGmapGoogleMapApiProvider'
  (uiGmapGoogleMapApiProvider) ->
    uiGmapGoogleMapApiProvider.configure
      key: 'AIzaSyAp8bPIoYNs2eyclr873VwWrbvzCPyaCUs',
      v: '3.17',
      libraries: 'weather,geometry,visualization'
]

# .config [
#   'cfpLoadingBarProvider'
#   (cfpLoadingBarProvider) ->
#     cfpLoadingBarProvider.latencyThreshold = 0;
# ]

# Local Storage account binding
.run [
  '$rootScope', '$localStorage'
  ($rootScope, $localStorage) ->
    $localStorage.bind($rootScope, "account", null)
]

# Helpers $location
.run [
  '$rootScope', '$location', '$route', '$window'
  ($rootScope, $location, $route, $window) ->
    $rootScope.animateNone = true

    $rootScope.$on '$locationChangeStart', () ->
      $rootScope.routeDirection =
        if $location.back
          $location.back = false
          'back'
        else if $route.last && !$location.keep
          'forward'
        else
          null

    $rootScope.$on '$locationChangeSuccess', (event) ->
      if $location.keep
        $location.keep = false
        $route.current = $route.last

    $rootScope.$on '$routeChangeSuccess', () ->
      $route.last = $route.current

    $rootScope.back = () ->
      $location.back = true
      $window.history.back()

    $rootScope.search = (path, attrs) ->
      console.log(attrs)
      $location.path("/search/#{path}").search(attrs)
]

# Helpers $share
.run [
  '$rootScope', '$modal'
  ($rootScope, $modal) ->
    $rootScope.share = (data) ->
      $modal.open "分享",
        templateUrl: "templates/modals/baiduShare.html"
        onload: () ->
          baidu.socShare.init
            afterInit: (urls) ->
              $rootScope.shareUrls = urls
            client_id: "lev6yFpuN4BDsG9dDaNsNWQj"
            content: data.name
            u: encodeURIComponent(window.location.href)
            url: encodeURIComponent(window.location.href)
            pic_url: encodeURIComponent(data.image_url)
]

# Helpers $favorite
.run [
  '$rootScope', '$location', '$loader', '$alert'
  ($rootScope, $location, $loader, $alert) ->
    $rootScope.favorite = (type, id) ->
      if $rootScope.account
        $loader.post("/api/favorites/#{type}/#{id}")
          .success (data) ->
            $alert.info(data["info"])
      else
        $location.path("/login#{$location.$$path}")
]

# Helpers $priceNotification
.run [
  '$rootScope', '$location', '$loader', '$alert', '$modal'
  ($rootScope, $location, $loader, $alert, $modal) ->
    $rootScope.priceNotification = (type, id) ->
      if $rootScope.account
        $modal.open "降价通知",
          templateUrl: "templates/modals/priceNotification.html"
          onload: () ->
            $rootScope.priceNotificationUrl = "/api/price_notifications/#{type}/#{id}"
            $rootScope.priceNotificationCallback = (data) ->
              $alert.info(data["info"])
              $modal.close()
      else
        $location.path("/login#{$location.$$path}")
]

# Helpers $review
.run [
  '$rootScope', '$location', '$loader', '$alert', '$modal'
  ($rootScope, $location, $loader, $alert, $modal) ->
    $rootScope.review = (type, id) ->
      if $rootScope.account
        $modal.open "评价",
          templateUrl: "templates/modals/review.html"
          onload: () ->
            $rootScope.reviewUrl = "/api/reviews/#{type}/#{id}"
            $rootScope.reviewCallback = (data) ->
              $alert.info(data["info"])
              $modal.close()
      else
        $location.path("/login#{$location.$$path}")
]

# Local Storage city binding
.run [
  '$rootScope', '$localStorage'
  ($rootScope, $localStorage) ->
    $localStorage.bind($rootScope, "city", null)
]

# Get filters  加载筛选导航数据
.run [
  '$rootScope', '$loader'
  ($rootScope, $loader) ->
    $rootScope.filters = {}

    $rootScope.formatFilter = (filter) ->

      format = (filter) ->
        indexes = []
        menus = []

        formatNode = (parent) ->
          if parent.children
            menus.push parent.children
            for node, i in parent.children

              if angular.isDefined(node.id)
                node.params ||= {}
                node.params[filter.key] ||= node.id

              if parent.type && !node.type
                node.type = parent.type

              delete node.focus
              if node.id == filter.current
                node.focus = true
                filter.indexes = indexes.slice()
                filter.menus = menus.slice()

              indexes.push i
              formatNode(node)
              indexes.pop()
            menus.pop()

        formatNode(filter)
        filter.indexes ||= []
        filter.menus ||= [ filter.children ]

      if filter.link
        if $rootScope.filters[filter.link]
          filter.children = $rootScope.filters[filter.link]
          format(filter)
        else
          $loader.get("/api/#{filter.link}/filters.json")
            .success (data) ->
              filter.children = data
              format(filter)
              $rootScope.filters[filter.link] = filter.children
      else
        format(filter)

]

# Helper $coords
.run [
  '$rootScope',
  ($rootScope) ->
    navigator.geolocation.getCurrentPosition (geoposition) ->
      console.info coords: geoposition.coords
      $rootScope.coords = geoposition.coords
    $rootScope.getDistance = (data) ->
      coords = $rootScope.coords
      if data && data.lat && data.lng && coords
        dLat = (data.lat-coords.latitude)*110.54
        dLng = (data.lng-coords.longitude)*Math.cos(data.lat)*111.32
        Math.sqrt(dLat*dLat+dLng*dLng)
      else
        0
]

.run [
  '$rootScope',
  ($rootScope) ->
    $rootScope.newRedirectolink = [
      "privileges/hospitals"
      "privileges/insurances"
      "privileges/maternals/maternal_halls"
      "privileges/maternals/confinement_centers"
      "privileges/newest"
    ]
]
#= require_tree ./routes
