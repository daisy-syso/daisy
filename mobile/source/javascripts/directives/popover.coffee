angular.module('DaisyApp').directive 'popover', [
  '$loader', '$rootScope'
  ($loader, $rootScope) ->
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
          if column.url
            scope.$parent.redirectTo = 
              url: column.url
              params: column.params || {}
          else if column.params
            scope.$parent.redirectTo = 
              url: scope.$parent.redirectTo.url
              params: angular.extend {}, 
                scope.$parent.redirectTo.params, column.params
                
          $rootScope[scope.current.keep] = column if scope.current.keep
          $rootScope.popover.close()

]