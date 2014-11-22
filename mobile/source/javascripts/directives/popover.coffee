angular.module('DaisyApp').directive 'popover', [
  '$loader', '$rootScope', '$route'
  ($loader, $rootScope, $route) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/popover.html"
      scope:
        popover: "="
      link: (scope, element, attrs) ->

        scope.$watch 'popover', (popover) ->
          if popover
            $rootScope.formatFilter(popover)
            scope.current = popover

        $rootScope.popover =
          toggle: () ->
            if $rootScope.popover.show
              $rootScope.popover.close()
            else
              $rootScope.popover.show = true

          close: () ->
            $rootScope.popover.show = false

        scope.toggleColumn = (i, j, children) ->
          scope.current.indexes.splice i
          scope.current.indexes.push j
          scope.current.menus.splice i + 1
          scope.current.menus.push children

        scope.redirectTo = (column) ->
          listScope = $route.current.scope

          if column.type
            type = column.type
            params = column.params || {}
          else
            type = listScope.type
            params = angular.extend {}, 
              listScope.params, column.params
          listScope.redirectTo type, params
          
          keep = scope.current.keep
          $rootScope[keep] = column if keep
          
          $rootScope.popover.close()

]