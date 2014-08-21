angular.module("DaisyApp").factory '$loader', ($http, $alert, $sce) ->
  error = (data, status) ->
    if data.error
      console.log data
      $alert.error(data.error)

  loader =
    get: (url, config) ->
      $http.get(url, config).error(error)

    post: (url, data, config = {}) ->
      $http.post(url, data, config).error(error)