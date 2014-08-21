angular.module("DaisyApp").factory '$backdrop', ($rootScope) ->
  $rootScope.backdrop = {}
  $rootScope.$backdrop =
    show: () -> $rootScope.backdrop.show = true
    hide: () -> $rootScope.backdrop.show = false

angular.module("DaisyApp").factory '$modal', ($rootScope, $backdrop) ->
  $rootScope.modal = {}
  $rootScope.$modal =
    show: (title, options = {}) -> 
      $rootScope.modal.title = title
      $rootScope.modal.content = options.content
      $rootScope.modal.templateUrl = options.templateUrl
      $rootScope.modal.onload = options.onload
      $rootScope.backdrop.click = $rootScope.$modal.hide
      $rootScope.backdrop.show = true
      $rootScope.modal.show = true

    hide: () -> 
      $rootScope.backdrop.click = null
      $rootScope.backdrop.show = false
      $rootScope.modal.show = false