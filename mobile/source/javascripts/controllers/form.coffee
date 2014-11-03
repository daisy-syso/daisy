angular.module('DaisyApp').controller 'FormCtrl', [
  '$scope', '$rootScope', '$loader', '$routeParams', '$location', '$timeout'
  ($scope, $rootScope, $loader, $routeParams, $location, $timeout) ->
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

    $scope.afterOrder = (data) ->
      $rootScope.alert.succ data.info
      $timeout () ->
        window.open(data.url)
      , 3000

    $scope.loginByOAuth = (provider, data) ->
      $loader.post "/api/sign_in/#{provider}", 
        account: data
      .success (data) ->
        $scope.afterLogin(data)

    $scope.loginByWB = () ->
      login = () ->
        $scope.loginByOAuth("weibo", WB2.oauthData)
        
      if WB2.checkLogin()
        login()
      else
        WB2.login (result) ->
          login()

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
          $scope.loginByQCFirsttime = true

        QC.Login.showPopup
          appId: "101150059"

]

