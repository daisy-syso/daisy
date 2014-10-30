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
      .success (data) ->
        $scope.afterLogin(data)

    $scope.loginByWB = () ->
      if WB2.checkLogin()
        $scope.loginByOAuth("weibo", WB2.oauthData)
      else
        WB2.login (result) ->
          $scope.loginByOAuth("weibo", result)

    $scope.loginByQC = () ->
      login = () ->
        QC.Login.getMe (openId, accessToken) ->
          $scope.loginByOAuth "qqconnect",
            uid: openId
            access_token: accessToken

      if QC.Login.check()
        login()
      else
        unless $scope.loginByQCFirsttime
          QC.Login {}, (reqData, opts) ->
            login()
            console.log reqData
          $scope.loginByQCFirsttime = true

        QC.Login.showPopup
          appId: "101165275"

]

