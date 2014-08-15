angular.module('DaisyApp').controller 'MainCtrl', ($rootScope, $http) ->
  $http.get("/api/app.json")
  .success (data) ->
    $rootScope.appData = data