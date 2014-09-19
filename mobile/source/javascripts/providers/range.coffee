angular.module("DaisyApp").filter 'range', () ->
  range = (from, to, step = 1) ->
    (x for x in [from...to] by step)