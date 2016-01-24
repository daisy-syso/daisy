changeSubType = ->
  $(".sub-type").on "click", () ->
    # get the sub-type id
    subTypeName = $(this).data("name")
    # set the current sub-type id to the load more
    $loadMore = $(this).parents(".infor-module").find(".load-more")
    $loadMore.attr("data-current-type", subTypeName)
    # set the current page
    $loadMore.attr("data-current-page", 1)
    # get the data
    $.ajax
      method: 'GET',
      url: "information/more_information?type=#{subTypeName}",
      success: (data) =>
        infors = data.data

loadMore = ->
  $(".load-more a").on "click", () ->
    currentType =  $(this).attr("data-current-type")
    currentPage =  Number($(this).attr("data-current-page")) + 1
    $(this).attr("data-current-page", "#{currentPage}")

    $.ajax
      method: 'GET',
      url: "information/more_information?page=#{currentPage}&name=#{currentType}",
      success: (data) =>
        infors = data.data
        htmlList = ""
        _.templateSettings = {
          interpolate: /\{\{\=(.+?)\}\}/g,
          evaluate: /\{\{(.+?)\}\}/g
        }
        template = _.template($("#information_item").html())
        htmlfrag = template({infors: infors})

        $(this).parents(".infor-module").find(".information-items li:last").append(htmlfrag)

ready = () ->
  changeSubType()
  loadMore()

$(document).on("ready", ready)
