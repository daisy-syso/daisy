angular.module('DaisyApp').directive 'dropDown', [
	'$swipe'
	($swipe) ->
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

				scope.showList = (i) ->
					if scope.ifShow[i]
					  $("i", element[0].children[i]).removeClass("ion-chevron-up")
					  $("i", element[0].children[i]).addClass("ion-chevron-down")
					  scope.ifShow[i] = false
				  else	
					  $("i", element[0].children[i]).removeClass("ion-chevron-down")
					  $("i", element[0].children[i]).addClass("ion-chevron-up")
					  scope.ifShow[i] = true

			  $swipe.bind( $('.test'),
          'start': (obj, event) ->
            console.log(obj)
            console.log(event)
            console.log("start")
          'move': () ->
            console.log("move")
          'end': (obj, event) ->
            console.log(obj)
            console.log("end")
        )
]