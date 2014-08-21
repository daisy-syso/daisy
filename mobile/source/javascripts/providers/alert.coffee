angular.module("DaisyApp").factory '$alert', [
  '$rootScope', '$interval'
  ($rootScope, $interval) ->
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

      $interval.cancel(lastInterval) if lastInterval
      lastInterval = $interval () ->
        $rootScope.alert.show = false
        lastInterval = null
      , 5000, 1

    $rootScope.alert =
      info: (message) -> open("info", message)
      succ: (message) -> open("success", message)
      warn: (message) -> open("warning", message)
      error: (message) -> open("danger", message)
      close: () -> $rootScope.alert.show = false
]