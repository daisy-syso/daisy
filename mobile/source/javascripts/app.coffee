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
  "angular-carousel"
  # "angular-loading-bar"
  "angular-local-storage"
]

.config ($routeProvider, $locationProvider) ->
  $routeProvider.when '/',          templateUrl: "templates/home.html"
  $routeProvider.when '/home',      templateUrl: "templates/home.html"
  $routeProvider.when '/login',     templateUrl: "templates/login.html"
  $routeProvider.when '/register',  templateUrl: "templates/register.html"
  $routeProvider.when '/retrieve',  templateUrl: "templates/retrieve.html"
  $routeProvider.when '/search',    templateUrl: "templates/search.html"
  $routeProvider.when '/favorites', templateUrl: "templates/favorites.html"
  $routeProvider.when '/detail',    templateUrl: "templates/detail.html"
  $routeProvider.when '/list',      templateUrl: "templates/list.html"
  $routeProvider.when '/search/:query',   
    templateUrl: "templates/list.html"
    controller: ($scope, $route, $localStorage) ->
      query = $route.current.params.query
      searchHistory = $localStorage.get("searchHistory")
        .filter (word) -> word != query
      searchHistory.unshift query
      $localStorage.set("searchHistory", searchHistory)

  $routeProvider.otherwise redirectTo: '/'

# For route#back
.run ($rootScope, $location) ->
  history = []

  $rootScope.$on '$routeChangeSuccess', () ->
    history.push($location.$$path)

  $rootScope.back = () ->
    prevUrl = if history.length > 1 then history.splice(-2)[0] else "/"
    $location.path(prevUrl)
