angular.module('DaisyApp').controller 'DropdownCtrl', ($scope, $location) ->
  $scope.toggle = () ->
    $scope.dropdown = not $scope.dropdown
