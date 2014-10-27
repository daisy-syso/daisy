angular.module('DaisyApp').directive 'popover', [
  '$loader', '$rootScope'
  ($loader, $rootScope) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/popover.html"
      scope:
        popover: "=?"
        popoverData: "=?"
        popoverLink: "@"
        popoverKeep: "@"
      link: (scope, element, attrs) ->

        scope.$watch 'popoverLink', (popoverLink) ->
          if popoverLink
            if $rootScope.filters[popoverLink]
              scope.popoverData = $rootScope.filters[popoverLink]
            else
              $loader.get("/api/#{popoverLink}/filters.json")
                .success (data) ->
                  $rootScope.filters[popoverLink] = data
                  scope.popoverData = data
        
        scope.$watch 'popover', (data) ->
          scope.popoverData = data if data

        $rootScope.popover =
          toggle: () ->
            if $rootScope.popover.show
              $rootScope.popover.close()
            else
              $rootScope.popover.show = true
              scope.currIndexes = []
              scope.currMenus = [ scope.popoverData ]

          close: () ->
            $rootScope.popover.show = false

        scope.toggleColumn = (i, j, children) ->
          scope.currIndexes.splice i
          scope.currIndexes.push j
          scope.currMenus.splice i + 1
          scope.currMenus.push children

        scope.redirectTo = (data) ->
          if data.url
            scope.$parent.redirectToUrl = data.url
            scope.$parent.redirectToParams = data.params || {}
          else
            scope.$parent.redirectToParams = angular.extend {}, 
              scope.$parent.redirectToParams, data.params
          $rootScope[scope.popoverKeep] = data if scope.popoverKeep
          $rootScope.popover.close()

]