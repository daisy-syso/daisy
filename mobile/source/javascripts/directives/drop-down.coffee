angular.module('DaisyApp').directive 'dropDown', () ->
	directive =
		restrict: 'A'
		link: (scope, element, attrs) ->
			scope.ifShow = []
			scope.showDoctors = (i) ->
				console.log("click")
				if scope.ifShow[i]
          scope.ifShow[i] = false
      	else
          scope.ifShow[i] = true