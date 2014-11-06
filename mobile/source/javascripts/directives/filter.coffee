angular.module('DaisyApp').directive 'filter', [
  '$location', '$loader', '$rootScope'
  ($location, $loader, $rootScope) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/filter.html"
      scope:
        filterData: "="
      link: (scope, element, attrs) ->

        scope.currTitles = {}

        scope.$watch 'filterData', (filterData) ->
          if filterData
            for filter in filterData
              $rootScope.getFilters(filter, 'children', filter.link)
        
        scope.toggleMenu = (index, menu) ->
          if scope.currIndex == index
            scope.closeMenu()
          else
            scope.currIndex = index
            scope.currMenu = menu

            ret = $rootScope.formatFilter(menu)
            scope.currSubIndexes = ret[0]
            scope.currSubMenus = ret[1]

        scope.toggleColumn = (i, j, column) ->
          scope.currSubIndexes.splice i
          scope.currSubIndexes.push j
          scope.currSubMenus.splice i + 1
          scope.currSubMenus.push column.children

        scope.redirectTo = (i, j, column) ->
          scope.currSubIndexes.splice i
          scope.currSubIndexes.push j

          if column.url
            scope.$parent.redirectToUrl = column.url
            scope.$parent.redirectToParams = column.params || {}
          else if column.params
            scope.$parent.redirectToParams = angular.extend {}, 
              scope.$parent.redirectToParams, column.params

          if column.title
            scope.currTitles[scope.currIndex] = column.parentTitle || column.title 

          scope.closeMenu()

        scope.closeMenu = () ->
          scope.currIndex = -1
          scope.currMenu = null

        scope.filtered = (menus) ->
          filtered = (menus) ->
            ret = []
            for menu in menus
              if menu.title.indexOf(scope.filter) >= 0
                ret.push menu
            ret

          if scope.filter
            filtered(menus)
          else
            menus

        scope.templateUrl = (data) ->
          "templates/filters/#{data.template||'list'}.html"
]
