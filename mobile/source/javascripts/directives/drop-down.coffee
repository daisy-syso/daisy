angular.module('DaisyApp').directive 'dropDown', () ->
	directive =
		restrict: 'A'
		link: (scope, element, attrs) ->
			scope.ifShow = []
			scope.showDoctors = (i) ->
				if scope.ifShow[i]
					$("i", element[0].children[i]).removeClass("ion-chevron-up")
					$("i", element[0].children[i]).addClass("ion-chevron-down")
					scope.ifShow[i] = false
				else	
					$("i", element[0].children[i]).removeClass("ion-chevron-down")
					$("i", element[0].children[i]).addClass("ion-chevron-up")
					scope.ifShow[i] = true