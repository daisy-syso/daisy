angular.module('DaisyApp').directive 'search', [
  '$loader', '$rootScope', '$route', '$timeout'
  ($loader, $rootScope, $route, $timeout) ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/search.html"
      # scope:
      link: (scope, element, attrs) ->

        # scope.$watch 'popover', (popover) ->
        #   if popover
        #     $rootScope.formatFilter(popover)
        #     scope.current = popover

        #     if popover.keep && $rootScope[popover.keep]
        #       $rootScope.popover.title = $rootScope[popover.keep].title   
        scope.enOfzh = 
          hospital: "医院"
          doctor: "医生"
          symptom: "症状"
          disease: "疾病"
          drug: "药品"
          manufactory: "药店"
        element.find('input').bind "keydown keypress", (event) ->
          if event.which == 13
            console.log(attrs)
            current_label = scope.current_label
            query = scope.query
            scope.$apply () ->
              scope.$eval($rootScope.search("#{current_label}/#{query}"))
              # scope.$eval($rootScope.search("hospital"))
              console.log("#{current_label}?query=#{query}")
            event.preventDefault()

        scope.labels = ['hospital', 'doctor', 'symptom', 'disease', 'drug', 'manufactory']
        
        scope.placeholder = "请输入您要搜索的医院"
        scope.current_label = "hospital"
        # timeout = 0
        scope.toggleLabel = (label) ->
          scope.current_label = label
          label = scope.enOfzh[label]          
          scope.placeholder = "请输入您要搜索的#{label}"
          scope.resault_list = []
        scope.$watch 'query', (query) -> 
          if query
            $timeout.cancel(timeout) if timeout
            timeout = $timeout(
              () ->
                label = scope.current_label
                query = scope.query
                params = { label: label, query: query }
                $loader.get("/api/search_index.json", params: params )
                  .success (data) ->
                    scope.resault_list = data
                
                console.log('sucess')
              , 350)
          else 
            scope.resault_list = []


           

        $rootScope.popupBox =
          toggle: () ->
            if $rootScope.popupBox.show
              $rootScope.popupBox.close()
            else
              $rootScope.popupBox.show = true

          close: () ->
            $rootScope.popupBox.show = false

        # scope.toggleColumn = (i, j, children) ->
        #   scope.current.indexes.splice i
        #   scope.current.indexes.push j
        #   scope.current.menus.splice i + 1
        #   scope.current.menus.push children

        # scope.redirectTo = (column) ->
        #   listScope = $route.current.scope

        #   if column.type
        #     type = column.type
        #     params = column.params || {}
        #   else
        #     type = listScope.type
        #     params = angular.extend {}, 
        #       listScope.params, column.params
        #   listScope.redirectTo? type, params

        #   keep = scope.current.keep
        #   $rootScope[keep] = column if keep
          
        #   $rootScope.popupBox.close()

]


# angular.module('DaisyApp').filter 'to_zh',
#   (enl) ->
#     enOfzh = 
#       hospital: "医院"
#       doctor: "医生"
#       symptom: "症状"
#       disease: "疾病"
#       drug: "药品"
#       manufactory: "药店"
#     return enOfzh[enl]



