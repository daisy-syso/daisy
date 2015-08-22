angular.module('DaisyApp').directive 'filter', [
  '$loader', '$rootScope', '$route'
  ($loader, $rootScope, $route) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/filter.html"
      scope:
        filterData: "="
      link: (scope, element, attrs) ->
        scope.current = 
          titles: {}

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
            if scope.current.menu.current && scope.current.menu.children
              console.log("===============")
              console.log(scope.current.menu.children)
              # i = scope.current.menu.current-1
              # scope.toggleColumn(0, i, scope.current.menu.children[i])

        scope.toggleColumn = (i, j, column) ->

          # console.log(i)
          # console.log(j)
          # console.log(column)
          scope.current.menu.indexes.splice i
          scope.current.menu.indexes.push j
          scope.current.menu.menus.splice i + 1
          scope.current.menu.menus.push column.children

        scope.redirectTo = (column) ->
          return if column.url
          listScope = $route.current.scope
          if column.type
            type = column.type
            params = column.params || {}
          else
            type = listScope.type
            params = angular.extend {}, 
              listScope.params, column.params
          listScope.redirectTo type, params

          keep = scope.current.menu.keep
          listScope[keep] = column if keep

          scope.current.titles[scope.current.index] = 
            column.filterTitle || column.title

          listScope.title = column.pageTitle

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
