changeSubType = ->
  $(".sub-type").on "click", () ->
    # get the sub-type id
    subTypeId = $(this).data("id")
    # set the current sub-type id to the load more
    $loadMore = $(this).parents(".infor-module").find(".load-more")
    $loadMore.attr("data-current-type", subTypeId)
    # set the current page
    $loadMore.attr("data-current-page", 1)
    # get the data
    $.ajax
      method: 'GET',
      url: "api/infors/health_infors.json?type=#{subTypeId}",
      success: (data) =>
        infors = data.data[0].latest_informations

loadMore = ->
  $(".load-more a").on "click", () ->
    currentType =  $(this).data("current-type")
    currentPage =  Number($(this).data("current-page")) + 1
    $(this).attr("data-current-page", "#{currentPage}")

    $.ajax
      method: 'GET',
      url: "api/infors/health_infors.json?page=#{currentPage}&type=#{currentType}",
      success: (data) =>
        infors = data.data[0].latest_informations
        htmlList = ""
        templte = "<li> <a href='/information/$id$'>$name$</a></li>"
        infors.forEach (info) ->
          htmlList += template.temp(info)

        $(this).parents(".infor-module").find(".information-items li:last").append(htmlList)

ready = () ->
  String.prototype.temp = (obj) ->
    return this.replace /\$\w+\$/gi, (matchs) ->
      returns = obj[matchs.replace(/\$/g, "")]
      return (returns + "") == "undefined"? "": returns;
  changeSubType()
  loadMore()

$(document).on("ready", ready)
