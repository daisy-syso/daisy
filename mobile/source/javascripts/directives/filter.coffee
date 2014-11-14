angular.module('DaisyApp').directive 'filter', [
  '$location', '$loader', '$rootScope'
  ($location, $loader, $rootScope) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/filter.html"
      scope:
        filterData: "="
      link: (scope, element, attrs) ->

        scope.current = {}
        scope.displayTitles = {}

        scope.$watch 'filterData', (filterData) ->
          if filterData
            for filter, index in filterData
              $rootScope.formatFilter(filter)
                
        scope.toggleMenu = (index, menu) ->
          if scope.current.index == index
            scope.closeMenu()
          else
            scope.current.index = index
            scope.current.menu = menu

        scope.toggleColumn = (i, j, column) ->
          scope.current.menu.indexes.splice i
          scope.current.menu.indexes.push j
          scope.current.menu.menus.splice i + 1
          scope.current.menu.menus.push column.children

        scope.redirectTo = (column) ->
          if column.url
            scope.$parent.redirectTo = 
              url: column.url
              params: column.params || {}
            scope.displayTitles = {}
          else if column.params
            scope.$parent.redirectTo = 
              params: angular.extend {}, 
                scope.$parent.redirectTo.params, column.params

          if column.title
            scope.displayTitles[scope.current.index] = 
              column.parentTitle || column.title 

          scope.closeMenu()

        scope.closeMenu = () ->
          scope.current.index = -1
          scope.current.menu = null

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
