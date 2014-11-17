angular.module('DaisyApp').directive 'list', [
  '$loader'
  ($loader) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/list.html"
      scope:
        listUrl: "@"
        listData: "=?"
        listFin: "=?"
        listTitle: "@"
        listMore: "@"
        listMoreLink: "@"
        listLoadMore: "@"
      link: (scope, element, attrs) ->
        if scope.listUrl
          $loader.get(scope.listUrl)
            .success (json) ->
              scope.listFin = json.fin
              scope.listData = json.data

        scope.link = (data) ->
          data.url || "#/detail/#{data.type}/#{data.id}"
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.type}.html"

]
