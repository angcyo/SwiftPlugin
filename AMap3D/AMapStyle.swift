//
// Created by angcyo on 21/09/07.
//

import Foundation
import MAMapKit

/// 地图组件/样式控制

class AMapStyle {

    /// 地图组件
    var mapView: MAMapView!

    /// 显示定位小蓝点 https://lbs.amap.com/api/ios-sdk/guide/create-map/location-map
    var showUserLocation: Bool = true

    ///用户跟踪模式
    var userTrackingMode: MAUserTrackingMode = .follow
    ///< 不追踪用户的location更新
    ///   none = 0
    ///< 追踪用户的location更新
    //   follow = 1
    ///< 追踪用户的location与heading更新
    ///  followWithHeading = 2

    //MARK: 自定义小蓝点

    let locationRepresentation = MAUserLocationRepresentation()

    /// 开始初始化
    func initMapView(_ mapView: MAMapView) {
        self.mapView = mapView
        updateStyle()
    }

    /// 更新样式
    func updateStyle() {
        with(mapView) {
            $0.showsUserLocation = showUserLocation
            $0.userTrackingMode = userTrackingMode

            //
            $0.update(locationRepresentation)
        }
    }

    /// 自定义地图 https://lbs.amap.com/api/ios-sdk/guide/create-map/custom
    func setCustomMapStyleOptions(stylePath: String = "/amap_style.data", styleExtraPath: String = "/amap_style_extra.data") {
        var path = Bundle.main.bundlePath
        path.append(stylePath)
        let data = NSData(contentsOfFile: path)

        var extraPath = Bundle.main.bundlePath
        extraPath.append(styleExtraPath)
        let extraData = NSData(contentsOfFile: extraPath)

        let options = MAMapCustomStyleOptions()
        options.styleData = data! as Data
        options.styleExtraData = extraData! as Data

        mapView.setCustomMapStyleOptions(options)
        mapView.customMapStyleEnabled = true
    }
}