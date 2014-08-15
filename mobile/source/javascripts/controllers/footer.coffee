angular.module('DaisyApp').controller 'FooterCtrl', ($scope, $location) ->
  $scope.active = (paths...) ->
    for path in paths
      return true if path == $location.$$path
    return false
