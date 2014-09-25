angular.module('DaisyApp').directive 'popover', [
  '$loader', '$rootScope'
  ($loader, $rootScope) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/popover.html"
      scope:
        popoverData: "="
      link: (scope, element, attrs) ->
        
        $rootScope.popover =
          toggle: () ->
            if $rootScope.popover.show
              $rootScope.popover.close()
            else
              $rootScope.backdrop.click = $rootScope.popover.close
              $rootScope.backdrop.zindex = 9
              $rootScope.backdrop.show = true
              $rootScope.popover.show = true
              scope.currIndexes = []
              scope.currMenus = [ scope.popoverData.children ]

          close: () ->
            $rootScope.backdrop.show = false
            $rootScope.popover.show = false

        scope.toggleColumn = (i, j, children) ->
          scope.currIndexes.splice i
          scope.currIndexes.push j
          scope.currMenus.splice i + 1
          scope.currMenus.push children

        scope.redirectTo = (options) ->
          scope.$parent.redirectToParams = angular.extend {}, 
            scope.$parent.redirectToParams, options
          $rootScope.popover.close()

]