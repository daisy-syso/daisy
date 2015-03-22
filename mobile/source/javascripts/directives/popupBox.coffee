angular.module('DaisyApp').directive 'popupBox', [
  '$loader', '$rootScope', '$route'
  ($loader, $rootScope, $route) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/popup_box.html"
      scope:
        popupBox: "="
      link: (scope, element, attrs) ->

        # scope.$watch 'popover', (popover) ->
        #   if popover
        #     $rootScope.formatFilter(popover)
        #     scope.current = popover

        #     if popover.keep && $rootScope[popover.keep]
        #       $rootScope.popover.title = $rootScope[popover.keep].title 

        $rootScope.popupBox =
          toggle: () ->
            if $rootScope.popupBox.show
              $rootScope.popupBox.close()
            else
              $rootScope.popupBox.show = true

          close: () ->
            $rootScope.popupBox.show = false

        # scope.toggleColumn = (i, j, children) ->
        #   scope.current.indexes.splice i
        #   scope.current.indexes.push j
        #   scope.current.menus.splice i + 1
        #   scope.current.menus.push children

        # scope.redirectTo = (column) ->
        #   listScope = $route.current.scope

        #   if column.type
        #     type = column.type
        #     params = column.params || {}
        #   else
        #     type = listScope.type
        #     params = angular.extend {}, 
        #       listScope.params, column.params
        #   listScope.redirectTo? type, params

        #   keep = scope.current.keep
        #   $rootScope[keep] = column if keep
          
        #   $rootScope.popupBox.close()

]