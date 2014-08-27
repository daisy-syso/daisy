angular.module('DaisyApp').directive 'map', [
  '$loader'
  ($loader) ->
    directive =
      restrict: 'A'
      scope:
        mapUrl: "@"
        mapData: "=?"
      link: (scope, element, attrs) ->
        scope.map = map = new BMap.Map(element[0])

        map.centerAndZoom(new BMap.Point(scope.mapData.lat, scope.mapData.lng), 14)

        # 添加地图缩放控件
        map.addControl(new BMap.ZoomControl())
        
        # 创建标注
        marker = new BMap.Marker(new BMap.Point(scope.mapData.lat, scope.mapData.lng))  
        # 将标注添加到地图中
        map.addOverlay(marker)              

        # 创建信息窗口
        infoWindow = new BMap.InfoWindow("普通标注")
        marker.addEventListener "click", () ->
          this.openInfoWindow infoWindow
]