angular.module('DaisyApp').directive 'list', [
  '$loader', '$alert'
  ($loader, $alert) ->
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
        number: "@"
      link: (scope, element, attrs) ->
        if scope.listUrl
          $loader.get(scope.listUrl)
            .success (json) ->
              scope.listFin = json.fin
              # $alert.info(json.data)
              scope.listData = json.data

        scope.link = (data) ->
          data.url || "#/detail/#{data.template}/#{data.id}" unless data.nolink
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.template}.html"

      controller: ($loader, $alert, $scope) ->
        $scope.addthumb = (id) ->
          url = "/api/hospitals/thumb.json"
          params = angular.extend { id: id }, params
          # $alert.info(id)
          $loader.get(url, params: params)
            .success (json) ->
              $scope.number = json.data.thumb
              # $alert.info(json.data)
]
