angular.module('DaisyApp').directive 'filter', [
  '$location', '$loader', '$rootScope'
  ($location, $loader, $rootScope) ->
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
            scope.currData = scope.filterData[index]

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

        scope.redirectTo = (data) ->
          if data.url
            scope.$parent.redirectToUrl = data.url
            scope.$parent.redirectToParams = data.params || {}
          else
            scope.$parent.redirectToParams = angular.extend {}, 
              scope.$parent.redirectToParams, data.params
          scope.closeMenu()

        scope.closeMenu = () ->
          scope.currIndex = -1
          scope.currMenus = null

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
          "templates/filters/#{data.template}.html"
]
