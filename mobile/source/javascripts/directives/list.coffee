angular.module('DaisyApp').directive 'list', [
  '$loader', '$alert', '$routeParams'
  ($loader, $alert, $routeParams) ->
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
        listFilters: "=?"
      link: (scope, element, attrs) ->
        if scope.listUrl
          console.log("#{$routeParams.only_onsales}======")
          params = {only_onsales: $routeParams.only_onsales }
          $loader.get(scope.listUrl, params: params)
            .success (json) ->
              scope.listFin = json.fin
              # $alert.info("1111related======#{json.data}")
              scope.listData = json.data

        # scope.$watch "data['title']", (value) ->
        #   $alert.info("/api/related_hospital.json?hospital_type=#{value}")
        #   $loader.get("/api/related_hospital.json?hospital_type=#{value}")
        #     .success (json) ->
        #       scope.listFin = json.fin
        #       $alert.info("json.fin=====#{json.fin}")
        #       $alert.info("json.data=====#{json.data}")
        #       scope.listData = json.data

        scope.link = (data) ->
          data.url || "#/detail/#{data.template}/#{data.id}" unless data.nolink
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.template}.html"

      controller: [
        '$scope', '$loader', '$alert'
        ($scope, $loader, $alert) ->
          $scope.addthumb = (hospital_onsale) ->
            url = "/api/hospitals/thumb.json"
            params = angular.extend { id: hospital_onsale.id }, params
            # $alert.info(id)
            $loader.get(url, params: params)
              .success (json) ->
                hospital_onsale.thumb = json.data.thumb
                # $alert.info(json.data)

      ]
]
