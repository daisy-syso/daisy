angular.module('DaisyApp').directive 'filter', [
  '$location', '$loader'
  ($location, $loader) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/filter.html"
      scope:
        filterData: "="
      link: (scope, element, attrs) ->

        scope.toggleMenu = (index, children) ->
          if scope.currIndex == index
            scope.closeMenu()
          else
            scope.currIndex = index
            scope.currIndexes = []
            scope.currMenus = [ children ]

        scope.toggleColumn = (i, j, children) ->
          scope.currIndexes.splice i
          scope.currIndexes.push j
          scope.currMenus.splice i + 1
          scope.currMenus.push children

        scope.toggleColumnLink = (i, j, column) ->
          $loader.get("/api/#{column.link}")
            .success (data) ->
              column.children = data['data']
              scope.toggleColumn i, j, column.children

        scope.redirectTo = (options) ->
          scope.$parent.redirectToParams = angular.extend {}, 
            scope.$parent.redirectToParams, options
          scope.closeMenu()

        scope.closeMenu = () ->
          scope.currIndex = -1
          scope.currMenus = null
]
