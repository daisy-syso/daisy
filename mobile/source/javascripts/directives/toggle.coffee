angular.module('DaisyApp').directive 'toggle', () ->
  directive =
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.on "click", () ->
        if $(this).is(".change")
          $(this).removeClass("change")
          $(this).find(".box").slideUp(300)
          return
        $("#symptoms").find(".box").slideUp(0);
        $(this).parent().find("li.change").removeClass("change")
        $(this).addClass("change")

        $(this).find(".box").slideDown(300)

