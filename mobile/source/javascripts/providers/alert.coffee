angular.module("DaisyApp").factory '$alert', [
  '$rootScope', '$timeout'
  ($rootScope, $timeout) ->
    lastInterval = null

    open = (type, message) ->
      $rootScope.alert.type = type
      if angular.isString(message)
        $rootScope.alert.message = message
        $rootScope.alert.messages = null
      else if angular.isArray(message)
        $rootScope.alert.message = null
        $rootScope.alert.messages = message
      $rootScope.alert.show = true

      $timeout.cancel(lastInterval) if lastInterval
      lastInterval = $timeout () ->
        $rootScope.alert.show = false
        lastInterval = null
      , 5000

    $rootScope.alert =
      info: (message) -> open("info", message)
      succ: (message) -> open("success", message)
      warn: (message) -> open("warning", message)
      error: (message) -> open("danger", message)
      close: () -> $rootScope.alert.show = false
]