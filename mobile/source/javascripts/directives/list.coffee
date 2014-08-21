angular.module('DaisyApp').directive 'list', ($loader) ->
  directive =
    restrict: 'A'
    templateUrl: "templates/directives/list.html"
    scope:
      listUrl: "@"
      listData: "=?"
      listTitle: "@"
      listMore: "@"
      listMoreLink: "@"
      listLoadMore: "@"
    link: (scope, element, attrs) ->
      if scope.listUrl
        $loader.get(scope.listUrl)
          .success (json) ->
            scope.listData = json.data
