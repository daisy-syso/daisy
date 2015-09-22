angular.module('DaisyApp').directive 'map', [
  '$loader'
  ($loader) ->
    directive =
      restrict: 'A'
      scope:
        mapUrl: "@"
        mapData: "=?"
      link: (scope, element, attrs) ->
        map = new BMap.Map(element[0])

        # 添加地图缩放控件
        # map.addControl(new BMap.ZoomControl())
        map.addControl(new BMap.NavigationControl());        # 添加平移缩放控件
        map.addControl(new BMap.ScaleControl());             # 添加比例尺控件
        map.addControl(new BMap.OverviewMapControl());

        scope.$watch "mapData", (data) ->
          if data && data.lng && data.lat
            map.centerAndZoom(new BMap.Point(data.lng, data.lat), 14)

            # 创建标注
            marker = new BMap.Marker(new BMap.Point(data.lng, data.lat))
            # 将标注添加到地图中
            map.addOverlay(marker)

            # 创建信息窗口
            infoWindow = new BMap.InfoWindow(data.name)
            marker.addEventListener "click", () ->
              this.openInfoWindow infoWindow
]
