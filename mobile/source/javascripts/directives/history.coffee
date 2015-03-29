angular.module('DaisyApp').directive 'history', [
  '$localStorage'
  ($localStorage) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/history.html"
      link: (scope, element, attrs) ->
        $localStorage.bind(scope, "searchHistory", [])
        console.log(scope.searchHistory)
]
