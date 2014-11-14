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
            scope.popover = popover

        $rootScope.popover =
          toggle: () ->
            if $rootScope.popover.show
              $rootScope.popover.close()
            else
              $rootScope.popover.show = true

          close: () ->
            $rootScope.popover.show = false

        scope.toggleColumn = (i, j, children) ->
          scope.popover.indexes.splice i
          scope.popover.indexes.push j
          scope.popover.menus.splice i + 1
          scope.popover.menus.push children

        scope.redirectTo = (column) ->
          if column.url
            scope.$parent.redirectTo = 
              url: column.url
              params: column.params || {}
          else if column.params
            scope.$parent.redirectTo = 
              params: angular.extend {}, 
                scope.$parent.redirectTo.params, column.params
                
          $rootScope[scope.popover.keep] = column if scope.popover.keep
          $rootScope.popover.close()

]