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

    $scope.loginByOAuth = (provider, data) ->
      $loader.post "/api/sign_in/#{provider}", 
        account: data
      , (data) ->
        afterLogin(data)

    $scope.loginByWB = () ->
      if WB2.checkLogin()
        $scope.loginByOAuth("weibo", WB2.oauthData)
      else
        WB2.login (result) ->
          $scope.loginByOAuth("weibo", result)

]

