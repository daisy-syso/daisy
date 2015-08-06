#= require angular/angular
#= require angular-animate/angular-animate
#= require angular-route/angular-route
#= require angular-touch/angular-touch
#= require angular-carousel/dist/angular-carousel
#= require angular-loading-bar/build/loading-bar
#= require angular-bootstrap/ui-bootstrap-tpls
#= require ionic/release/js/ionic.bundle


angular.module 'DaisyApp', [
  "ngAnimate"
  "ngRoute"
  "ngTouch"
  "angular-local-storage"
  "angular-carousel"
  'ui.bootstrap'
  'ionic'
]

.config [
  '$routeProvider'
  ($routeProvider) ->
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

          $rootScope.$watch "city", (value) ->
            length = value?.title?.length || 2
            $rootScope.searchLeft = "#{20*length+40}px"
      ]

    $routeProvider.when '/infors/:type',
      templateUrl: (routeParams) ->
        "templates/#{routeParams.type}_infor.html"
      controller:[
        '$rootScope', '$scope', '$loader', '$routeParams'
        ($rootScope, $scope, $loader, $routeParams) ->
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
      '$scope', '$routeParams', '$loader', '$alert', '$location'
      ($scope, $routeParams, $loader, $alert, $location) ->
        $scope.type = $routeParams.type
        if $routeParams.type == "hospitals/hospitals_polyclinic"
          $scope.type = "hospitals/hospitals"
          # $alert.info($scope.type)
        $scope.id = $routeParams.id
        $scope.detail_id = $routeParams.detail
        # url = "/api/#{$routeParams.type}/#{$routeParams.id}.json"
        url = "/api/#{$scope.type}/#{$routeParams.id}.json"
        # $alert.info(url)
        params = angular.extend { onsale_id: $routeParams.onsale_id }, params
        # $alert.info($routeParams.onsale_id)
        $loader.get(url, params: params)
          .success (data) ->
            $scope.data = data['data']

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
            $scope.title = data.symptoms.symptom.name
    ]

    $routeProvider.when '/order/:type*/:id',
      templateUrl: "templates/order.html"
      controller: detailCtrl

    # $routeProvider.when '/detail/:type*/:id/:attr',
    #   templateUrl: "templates/details/display.html"
    #   controller: [
    #     '$scope', '$routeParams', '$loader'
    #     ($scope, $routeParams, $loader) ->
    #       $scope.type = $routeParams.type
    #       url = "/api/#{$routeParams.type}.json"
    #       scope.to_zh =
    #         by: "病因"
    #         zz: "症状"
    #         jc: "检测"

    #       scope.attr = $routeParams.attr
    #       $loader.get(url)
    #         .success (data) ->
    #           $scope.data = data
    #   ]

    $routeProvider.when '/detail/drugs/drugs/:id/:manufactory_id',
      templateUrl: "templates/details/drugs/drugs.html"
      controller: drugDetailCtrl

    $routeProvider.when '/detail/symptoms/symptoms/:id',
      templateUrl: "templates/details/symptoms/symptom_item.html"
      controller: symptomsDetailCtrl

    $routeProvider.when '/detail/:type*/:id',
      templateUrl: (routeParams) ->
        if routeParams.detail
          "templates/details/display.html"
        else if routeParams.type == "hospitals"
          "templates/details/#{routeParams.type}/#{routeParams.type}.html"
        else
          "templates/details/#{routeParams.type}.html"
      controller: detailCtrl

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
      '$scope', '$loader', '$route', '$location', '$routeParams'
      ($scope, $loader, $route, $location, $routeParams) ->
        url = if $routeParams.name
          "/api/drugs/drugs/drug_manufactories.json"
        else
          "/api/drugs/drugs.json"

        $scope.withTitle = $routeParams.name
        $scope.moreData = true

        $scope.drugUrl = (drug) ->
          if $routeParams.name
            "#/detail/drugs/drugs/#{ drug.drug_id }/#{drug.manufactory_id}"
          else
            "#/list/drugs/drugs?name=#{ drug.name } "

        $scope.loadData = (type, params) =>
          $scope.type = type
          $scope.params = params
          # $alert.info($scope.listUrl)
          page = $scope.page = 1
          params = angular.extend { page: page }, params
          $loader.get(url, params: params)
            .success (data) =>
              if data.drugs.length < 1  then  $scope.moreData = false
              $scope.drugs = data.drugs

        $scope.loadData($route.current.params.type, $location.search())
        $scope.loadMore = () ->
          page = $scope.page += 1
          params = angular.extend { page: page }, $scope.params
          $loader.get(url, params: params)
            .success (data) ->
              if data.drugs.length < 1
                $scope.moreData = false
              else
                $scope.drugs = $scope.drugs.concat data.drugs

    ]

    SymptomsListCtrl = [
      '$scope', '$loader', '$route', '$location', '$routeParams'
      ($scope, $loader, $route, $location, $routeParams) ->
        $scope.moreData = true
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

    $routeProvider.when '/list/symptoms/symptoms',
      templateUrl: 'templates/symptoms_list.html'
      controller: SymptomsListCtrl

    $routeProvider.when '/list/drugs/drugs',
      templateUrl: "templates/drugs_list.html"
      controller: DrugListCtrl

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
          console.log($location.search()+"=======location")
          console.log("query======#{query}")
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

    $routeProvider.otherwise redirectTo: '/home'
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

# Get filters
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
