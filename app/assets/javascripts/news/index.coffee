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
    currentType =  $(this).attr("data-current-type")
    currentPage =  Number($(this).attr("data-current-page")) + 1
    $(this).attr("data-current-page", "#{currentPage}")

    $.ajax
      method: 'GET',
      url: "api/infors/health_infors.json?page=#{currentPage}&type=#{currentType}",
      success: (data) =>
        infors = data.data[0].latest_informations
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
