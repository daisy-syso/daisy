angular.module('DaisyApp').controller 'MainCtrl', ($rootScope, $loader) ->
  $loader.get("/config/app.json")
    .success (data) ->
      $rootScope.appData = data
