angular.module('DaisyApp').controller 'FormCtrl', [
  '$scope', '$rootScope', '$loader', '$routeParams', '$location'
  ($scope, $rootScope, $loader, $routeParams, $location) ->
    $scope.submit = (url, data, callback) ->
      $loader.post(url, data)
        .success (data) ->
          callback(data) if callback

    $scope.redirectTo = () ->
      redirectToPath = $routeParams.redirectToPath
      $location.path(redirectToPath) if redirectToPath

    $scope.afterLogin = (data) ->
      $rootScope.account = data['data']
      $scope.redirectTo()
]

