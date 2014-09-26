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