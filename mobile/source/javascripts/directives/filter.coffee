angular.module('DaisyApp').directive 'filter', ($http) ->
  directive =
    restrict: 'A'
    templateUrl: "templates/directives/filter.html"
    scope:
      filterData: "="
    link: (scope, element, attrs) ->
      scope.toggle = (index) ->
        if scope.currIndex == index
          scope.currIndex = -1
          scope.currMenu = null
        else
          scope.currIndex = index
          scope.currMenu = scope.filterData[index]?.children

      scope.toggleSub = (index) ->
        scope.currSubIndex = index
        scope.currSubMenu = scope.currMenu[index]?.children
        console.log scope.currSubMenu
