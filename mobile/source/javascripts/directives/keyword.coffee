angular.module('DaisyApp').directive 'keyword', ($loader) ->
  directive =
    restrict: 'A'
    templateUrl: "templates/directives/keyword.html"
    scope:
      keywordUrl: "@"
    link: (scope, element, attrs) ->
      if scope.keywordUrl
        $loader.get(scope.keywordUrl)
          .success (json) ->
            scope.keywordData = json.data
