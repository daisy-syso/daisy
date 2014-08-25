angular.module("DaisyApp").filter 'limitToEllipsis', () ->
  cut = (value, max, tail = '…') ->
    if not value
      return ''

    max = parseInt(max, 10)
    if not max
      return value

    if value.length <= max
      return value

    value = value.substr(0, max)
    value + tail