angular.module("DaisyApp").factory '$backdrop', [
  '$rootScope'
  ($rootScope) ->
    $rootScope.backdrop =
      options: []

      open: (click, zindex) ->
        if $rootScope.backdrop.show
          $rootScope.backdrop.options.push(
            [$rootScope.backdrop.click, $rootScope.backdrop.zindex])
        else
          $rootScope.backdrop.show = true
        $rootScope.backdrop.click = click
        $rootScope.backdrop.zindex = zindex

      close: () -> 
        if $rootScope.backdrop.options.length > 0
          options = $rootScope.backdrop.options.pop()
          $rootScope.backdrop.click = options[0]
          $rootScope.backdrop.zindex = options[1]
        else
          $rootScope.backdrop.click = null
          $rootScope.backdrop.show = false

      remove: () ->
        $rootScope.backdrop.options = []
        $rootScope.backdrop.click = null
        $rootScope.backdrop.show = false
]

angular.module("DaisyApp").factory '$modal', [
  '$rootScope', '$backdrop'
  ($rootScope, $backdrop) ->
    $rootScope.modal =
      open: (title, options = {}) -> 
        $rootScope.modal.title = title
        $rootScope.modal.content = options.content
        $rootScope.modal.templateUrl = options.templateUrl
        $rootScope.backdrop.open($rootScope.modal.close, 15)
        $rootScope.modal.show = true
        options.onload() if options.onload

      close: () -> 
        $rootScope.backdrop.close()
        $rootScope.modal.show = false
]