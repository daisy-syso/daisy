angular.module('DaisyApp').directive 'autoFocus', () ->
  directive =
    link: 
      post: (scope, element, attr) ->
        element[0].focus()
