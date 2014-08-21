angular.module("DaisyApp").factory '$backdrop', [
  '$rootScope'
  ($rootScope) ->
    $rootScope.backdrop =
      open: () -> $rootScope.backdrop.show = true
      close: () -> $rootScope.backdrop.show = false
]

angular.module("DaisyApp").factory '$modal', [
  '$rootScope', '$backdrop'
  ($rootScope, $backdrop) ->
    $rootScope.modal =
      open: (title, options = {}) -> 
        $rootScope.modal.title = title
        $rootScope.modal.content = options.content
        $rootScope.modal.templateUrl = options.templateUrl
        $rootScope.modal.onload = options.onload
        $rootScope.backdrop.click = $rootScope.modal.close
        $rootScope.backdrop.show = true
        $rootScope.modal.show = true

      close: () -> 
        $rootScope.backdrop.click = null
        $rootScope.backdrop.show = false
        $rootScope.modal.show = false
]