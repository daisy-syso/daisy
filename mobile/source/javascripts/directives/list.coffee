angular.module('DaisyApp').directive 'list', [
  '$loader', '$alert', '$routeParams', '$ionicLoading'
  ($loader, $alert, $routeParams, $ionicLoading) ->
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
        listTpl: "@"
      link: (scope, element, attrs) ->
        if scope.listUrl
          scope.page = 1
          params = {only_onsales: $routeParams.only_onsales, page: scope.page }
          # $ionicLoading.show(
          #   template: '<ion-spinner class="spinner-wighte"></ion-spinner>',
          #   noBackdrop: true
          # )
          $('#loading_div').show()
          $loader.get(scope.listUrl, params: params)        
            .success (json) ->
              scope.listFin = json.fin
              scope.listData = json.data
              scope.moreShow = true unless json.data < 25
              # $ionicLoading.hide()
              $('#loading_div').hide()

        scope.loadMore = () ->
          scope.page += 1
          params = {only_onsales: $routeParams.only_onsales, page: scope.page }
          $ionicLoading.show(
            template: '<ion-spinner class="spinner-wighte"></ion-spinner>',
            noBackdrop: true
          )
          $loader.get(scope.listUrl, params: params)        
            .success (json) ->
              scope.listFin = json.fin
              scope.listData = scope.listData.concat json.data
              scope.moreShow = false if json.data < 25
              $ionicLoading.hide()
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
          scope.listTpl || "templates/lists/#{data.template}.html"

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
