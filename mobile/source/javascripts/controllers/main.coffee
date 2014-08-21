angular.module('DaisyApp').controller 'MainCtrl', ($rootScope, $loader) ->
  $loader.get("/api/config.json")
    .success (data) ->
      $rootScope.appData = data
