angular.module('DaisyApp').directive 'stars', () ->
    directive =
      restrict: 'A'
      templateUrl: "templates/directives/stars.html"
      scope:
        stars: "="
        clickable: "@"
      link: (scope, element, attrs) ->
        scope.stars ||= 0
        scope.$watch "stars", (stars) ->
          scope.starHalf = stars - parseInt(stars) > 0.5
          scope.star = [1...(1+parseInt(stars))]
          scope.starOutline = [(6-parseInt(5.5 - stars))...6]
        scope.clickStar = (index) ->
          console.log scope.clickable
          scope.stars = index if scope.clickable
