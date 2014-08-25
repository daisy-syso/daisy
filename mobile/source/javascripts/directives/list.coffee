angular.module('DaisyApp').directive 'list', [
  '$loader'
  ($loader) ->
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

        scope.link = (data) ->
          data.link || "#/detail/#{data.type}/#{data.id}"
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.type}.html"

]
