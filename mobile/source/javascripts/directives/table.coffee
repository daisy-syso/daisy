angular.module('DaisyApp').directive 'table', [
  '$loader', '$rootScope'
  ($loader, $rootScope) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/table.html"
      scope:
        tableUrl: "@"
        tableData: "=?"
        tablePer: "=?"
        tableFin: "=?"
        tableTitle: "@"
        tableMore: "@"
        tableMoreLink: "@"
        tableLoadMore: "@"
      link: (scope, element, attrs) ->
        if scope.tableUrl
          $loader.get(scope.tableUrl)
            .success (json) ->
              scope.tablePer = json.per
              scope.tableFin = json.fin
              scope.tableData = json.data

        tableize = (data, per) ->
          tableData = []
          for i in [0...data.length] by per
            tableData.push data[i...i+per]
          tableData

        scope.$watch "tableData", (data) ->
          if data
            scope.tableRowData = tableize(data, scope.tablePer)

        scope.link = (data) ->
          data.link || "#/detail/#{data.type}/#{data.id}"
          
        scope.templateUrl = (data) ->
          "templates/lists/#{data.type}.html"

]
