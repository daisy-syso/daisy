#= require angular/angular
#= require angular-animate/angular-animate
#= require angular-route/angular-route
#= require angular-touch/angular-touch
#= require angular-carousel/dist/angular-carousel
#= require angular-loading-bar/build/loading-bar

angular.module 'DaisyApp', [
  "ngAnimate"
  "ngRoute"
  "ngTouch"
  "angular-local-storage"
  "angular-carousel"
  "angular-loading-bar"
]

.config [
  '$routeProvider', '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider.when '/home',
      templateUrl: "templates/home.html"
      controller: [
        '$rootScope', '$loader'
        ($rootScope, $loader) ->
          unless $rootScope.homeData
            $loader.get("/api/home.json")
              .success (data) ->
                $rootScope.homeData = data
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

    $routeProvider.otherwise redirectTo: '/home'
]

.config [
  'cfpLoadingBarProvider'
  (cfpLoadingBarProvider) ->
    cfpLoadingBarProvider.latencyThreshold = 0;
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
    locationBack = false
    pageReady = false

    $rootScope.$on '$routeChangeStart', () ->
      $rootScope.pageReady = pageReady
      pageReady = true
      $rootScope.locationBack = locationBack
      locationBack = false

    $rootScope.$on '$routeChangeSuccess', () ->
      history.push($location.$$path)

    $rootScope.back = () ->
      locationBack = true
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

