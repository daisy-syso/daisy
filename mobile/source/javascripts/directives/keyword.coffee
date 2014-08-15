angular.module('DaisyApp').directive 'keyword', ($http) ->
  directive =
    restrict: 'A'
    templateUrl: "templates/directives/keyword.html"
    scope:
      keywordUrl: "@"
    link: (scope, element, attrs) ->
      if scope.keywordUrl
        $http.get(scope.keywordUrl)
          .success (json) ->
            scope.keywordData = json.data
