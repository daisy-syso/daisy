angular.module('DaisyApp').controller 'MainCtrl', ($rootScope, $http) ->
  $http.get("/config/app.json")
  .success (data) ->
    $rootScope.appData = data
