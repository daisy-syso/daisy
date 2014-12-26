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
              scope.listData = json.data

        scope.link = (data) ->
          data.url || "#/detail/#{data.template}/#{data.id}" unless data.nolink
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.template}.html"

      controller: ($loader, $alert, $scope) ->
        $scope.addthumb = (hospital_onsale_id) ->
          url = "/api/hospitals/thumb.json"
          $scope.number += 1
          $loader.get(url, hospital_onsale_id)
            .success (json) ->
              
              $alert.info(url)
]
