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

        scope.toggleMenu = (index, menu) ->
          if scope.currIndex == index
            scope.closeMenu()
          else
            scope.lastTitle = null
            scope.currIndex = index
            scope.currMenu = menu
            scope.currSubIndexes = []
            scope.currSubMenus = [ menu.children ]

        scope.toggleColumn = (i, j, column) ->
          scope.lastTitle = column.title
          scope.currSubIndexes.splice i
          scope.currSubIndexes.push j
          scope.currSubMenus.splice i + 1
          scope.currSubMenus.push column.children

        scope.loadColumnData = (i, j, column) ->
          $loader.get("/api/#{column.link}")
            .success (data) ->
              column.children = data['data']
              scope.toggleColumn i, j, column.children

        scope.redirectTo = (column) ->
          if column.url
            scope.$parent.redirectToUrl = column.url
            scope.$parent.redirectToParams = column.params || {}
          else
            scope.$parent.redirectToParams = angular.extend {}, 
              scope.$parent.redirectToParams, column.params
          if column.title
            if column.parent && scope.lastTitle
              scope.currTitles[scope.currIndex] = scope.lastTitle
            else
              scope.currTitles[scope.currIndex] = column.title 

          scope.closeMenu()

        scope.closeMenu = () ->
          scope.currIndex = -1
          scope.currSubMenus = null

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
