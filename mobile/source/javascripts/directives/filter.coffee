angular.module('DaisyApp').directive 'filter', ($location) ->
  directive =
    restrict: 'A'
    templateUrl: "templates/directives/filter.html"
    scope:
      filterData: "="
    link: (scope, element, attrs) ->
      close = () ->
        scope.currIndex = -1
        scope.currMenu = null

      scope.toggle = (index) ->
        if scope.currIndex == index
          close()
        else
          scope.currIndex = index
          scope.currMenu = scope.filterData[index]?.children
          scope.currSubIndex = -1
          scope.currSubMenu = null

      scope.toggleMenu = (index) ->
        scope.currSubIndex = index
        scope.currSubMenu = scope.currMenu[index]?.children
        unless scope.currSubMenu
          scope.$parent.loadJson = scope.currMenu[index]
          close()

      scope.toggleSubMenu = (index) ->
        scope.$parent.loadJson = scope.currSubMenu[index]
        close()
