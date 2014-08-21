angular.module("DaisyApp").factory '$alert', ($rootScope, $interval) ->
  $rootScope.alert = {}
  lastInterval = null

  show = (type, message) ->
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

  $rootScope.$alert =
    info: (message) -> show("info", message)
    succ: (message) -> show("success", message)
    warn: (message) -> show("warning", message)
    error: (message) -> show("danger", message)
    hide: () -> $rootScope.alert.show = false