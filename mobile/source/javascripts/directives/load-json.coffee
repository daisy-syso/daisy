angular.module('DaisyApp').directive 'loadJson', ($http) ->
  directive =
    restrict: 'A'
    scope:
      loadJson: "@"
    link: (scope, element, attrs) ->
      $http.get(scope.loadJson)
        .success (json) ->
          scope.$parent.data = json
