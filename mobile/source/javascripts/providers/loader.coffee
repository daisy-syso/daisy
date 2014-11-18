angular.module("DaisyApp").factory '$loader', [
  '$rootScope', '$http', '$location', '$alert'
  ($rootScope, $http, $location, $alert) ->
    error = (data, status) ->
      if data.error
        $alert.error(data.error)

        # if access denied
        if status == 401 && not /^\/login/.test $location.$$path
          $rootScope.account = null
          $location.path("/login#{$location.path()}")
          $location.replace()
      else
        $alert.error("未知错误")

    loader =
      get: (url, config = {}) ->
        defaultParams = {}

        if $rootScope.coords
          angular.extend defaultParams, 
            "location[lat]": $rootScope.coords.latitude
            "location[lng]": $rootScope.coords.longitude

        if $rootScope.city
          angular.extend defaultParams, $rootScope.city.params

        config.params = angular.extend defaultParams, config.params
        $http.get(url, config).error(error)

      post: (url, data, config = {}) ->
        $http.post(url, data, config).error(error)
]