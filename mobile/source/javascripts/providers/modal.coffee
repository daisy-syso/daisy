angular.module("DaisyApp").factory '$modal', [
  '$rootScope'
  ($rootScope) ->
    $rootScope.modal =
      open: (title, options = {}) -> 
        $rootScope.modal.title = title
        $rootScope.modal.content = options.content
        $rootScope.modal.templateUrl = options.templateUrl
        $rootScope.modal.show = true
        options.onload() if options.onload

      close: () -> 
        $rootScope.modal.show = false
]