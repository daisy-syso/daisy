angular.module('DaisyApp').directive 'stars', () ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/stars.html"
      scope:
        stars: "="
      link: (scope, element, attrs) ->
        scope.starHalf = () -> 
          scope.stars - parseInt(scope.stars) > 0.5
        scope.star = () -> 
          parseInt(scope.stars)
        scope.starOutline = () -> 
          parseInt(5.5 - scope.stars)
