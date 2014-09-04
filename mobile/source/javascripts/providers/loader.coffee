angular.module("DaisyApp").factory '$loader', [
  '$rootScope', '$http', '$location', '$alert'
  ($rootScope, $http, $location, $alert) ->
    error = (data, status) ->
      if data.error
        $alert.error(data.error)

        # if access denied
        if status == 401 && not /^\/login/.test $location.$$path
          $rootScope.account = null
          $location.path "/login#{$location.$$path}"
      else
        $alert "未知错误"

    loader =
      get: (url, config) ->
        $http.get(url, config).error(error)

      post: (url, data, config = {}) ->
        $http.post(url, data, config).error(error)
]