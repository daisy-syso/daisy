angular.module('DaisyApp').directive 'list', ($http) ->
  directive =
    restrict: 'A'
    templateUrl: "templates/directives/list.html"
    scope:
      listUrl: "@"
      listData: "=?"
      listTitle: "@"
      listMore: "@"
      listMoreLink: "@"
    link: (scope, element, attrs) ->
      if scope.listUrl
        $http.get(scope.listUrl)
          .success (json) ->
            scope.listData = json.data
