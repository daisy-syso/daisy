angular.module("DaisyApp").directive 'ngEnter', () ->
  return (scope, element, attrs) ->
    element.bind "keydown keypress", (event) ->
      if event.which == 13
        scope.$apply () ->
          scope.$eval(attrs.ngEnter)
          console.log(attrs.ngEnter)
        event.preventDefault()
