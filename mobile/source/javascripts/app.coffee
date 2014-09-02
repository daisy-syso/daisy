#= require angular/angular
#= require angular-animate/angular-animate
#= require angular-route/angular-route
#= require angular-touch/angular-touch
#= require angular-carousel/dist/angular-carousel
#= require angular-loading-bar/build/loading-bar

angular.module 'DaisyApp', [
  # "ngAnimate"
  "ngRoute"
  "ngTouch"
  "angular-local-storage"
  "angular-carousel"
  "angular-loading-bar"
]

.config [
  '$routeProvider', '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider.when '/',          templateUrl: "templates/home.html"
    $routeProvider.when '/home',      templateUrl: "templates/home.html"

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
    $routeProvider.when '/search',    templateUrl: "templates/search.html"
    $routeProvider.when '/favorites', templateUrl: "templates/favorites.html"
    
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

    $routeProvider.when '/detail/:type*/:id',
      templateUrl: (routeParams) ->
          "templates/details/#{routeParams.type}.html"
      controller: [
        '$scope', '$routeParams', '$loader'
        ($scope, $routeParams, $loader) ->
          $scope.type = $routeParams.type
          $scope.id = $routeParams.id
          url = "/api/#{$routeParams.type}/#{$routeParams.id}.json"

          $loader.get(url)
            .success (data) ->
              $scope.data = data['data']
      ]
    
    $routeProvider.when '/list/:type*',
      templateUrl: "templates/list.html"
      controller: [
        '$scope', '$routeParams', '$loader'
        ($scope, $routeParams, $loader) ->
          $scope.type = $routeParams.type
          url = "/api/#{$routeParams.type}.json"

          $scope.$watch 'redirectToParams', (redirectToParams) ->
            page = $scope.page = 1
            params = angular.extend { page: page }, redirectToParams
            $loader.get(url, params: params)
              .success (data) ->
                $scope.data = data

          $scope.loadMore = () ->
            page = $scope.page += 1
            redirectToParams = $scope.redirectToParams
            params = angular.extend { page: page }, redirectToParams
            $loader.get(url, params: params)
              .success (data) ->
                $scope.data['data'] = $scope.data['data'].concat data['data']
      ]

    $routeProvider.when '/search/:query',   
      templateUrl: "templates/list.html"
      controller: [
        '$scope', '$routeParams', '$localStorage'
        ($scope, $routeParams, $localStorage) ->
          query = $routeParams.query
          searchHistory = $localStorage.get("searchHistory")
            .filter (word) -> word != query
          searchHistory.unshift query
          $localStorage.set("searchHistory", searchHistory)
      ]

    $routeProvider.otherwise redirectTo: '/'
]

.config [
  'cfpLoadingBarProvider'
  (cfpLoadingBarProvider) ->
    cfpLoadingBarProvider.latencyThreshold = 0;
]

# Load App Config
.run [
  '$rootScope', '$loader'
  ($rootScope, $loader) ->
    $loader.get("/api/config.json")
      .success (data) ->
        $rootScope.appData = data
]

# Local Storage account binding
.run [
  '$rootScope', '$localStorage'
  ($rootScope, $localStorage) ->
    $localStorage.bind($rootScope, "account", null)
]

# Helpers $location
.run [
  '$rootScope', '$location'
  ($rootScope, $location) ->
    history = []

    $rootScope.$on '$routeChangeSuccess', () ->
      history.push($location.$$path)

    $rootScope.back = () ->
      prevUrl = if history.length > 1 then history.splice(-2)[0] else "/"
      $location.path(prevUrl)

    $rootScope.redirectTo = (path) ->
      $location.path(path)

    $rootScope.search = (query) ->
      $location.path("/search/#{query}")
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
            content: "您要分享的内容"
            u: encodeURIComponent("分享成功后或者分享编辑也取消分享时的返回地址")
            url: encodeURIComponent("您要分享的URL")
            pic_url: encodeURIComponent("您要分享的图片URL")
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
          onload: (scope) ->
            scope.priceNotificationUrl = "/api/price_notifications/#{type}/#{id}"
            scope.priceNotificationCallback = (data) ->
              $alert.info(data["info"])
              $modal.close()
      else
        $location.path("/login#{$location.$$path}")
]

# Helper $coords
.run [
  '$rootScope',
  ($rootScope) ->
    navigator.geolocation.getCurrentPosition (geoposition) ->
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

