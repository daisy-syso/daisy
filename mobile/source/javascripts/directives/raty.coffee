angular.module('DaisyApp').directive 'raty', () ->
  directive =
    restrict: "AE"
    link:
      post: (scope, element, attrs) ->
        $(element).raty
          score: scope[attrs.ngModel]
          number: attrs.number
          starOn : 'images/star.png'
          starOff  : 'images/ico-star.png'
          click: (score, event) ->
            scope[attrs.ngModel] = score;
            scope.$apply();
