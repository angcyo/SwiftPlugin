//
// Created by angcyo on 21/09/07.
//

import Foundation
import MAMapKit

class DslMapView: MAMapView, MAMapViewDelegate {

    var mapStyle: AMapStyle = AMapStyle()

    /// 首次加载移动到当前文职
    var firstMoveToLocation = true

    /// 点击地图时, 移动到目标
    var moveToLocationOnTapped = true

    func initView() {
        delegate = self
        mapStyle.initMapView(self)

        //地图的视图锚点
        //screenAnchor = cgPoint(x: 0.5, y: 0.5)
    }

    //MARK: - MAMapViewDelegate 代理回调

    //4.
    func mapInitComplete(_ mapView: MAMapView!) {
        L.d("地图初始化完成")
        if let _ = mapView.userLocation.location, firstMoveToLocation {
            mapView.setZoomLevel(AMap.DEF_ZOOM_LEVEL, animated: true)
        }
    }

    /// 开始加载地图
    func mapViewWillStartLoadingMap(_ mapView: MAMapView!) {
        L.d("开始加载地图")
    }

    /// 1. 开始定位
    func mapViewWillStartLocatingUser(_ mapView: MAMapView!) {
        L.d("开始定位:\(mapView.userLocation.location)")
    }

    func mapViewDidStopLocatingUser(_ mapView: MAMapView!) {
        L.d("结束定位:\(mapView.userLocation.location)")
    }

    func mapViewRequireLocationAuth(_ locationManager: CLLocationManager!) {
        L.d("请求定位权限")
        locationManager.requestAlwaysAuthorization()
    }

    func mapView(_ mapView: MAMapView!, didFailToLocateUserWithError error: Error!) {
        L.e("定位失败:\(error)")
    }

    /// 2. 地图区域即将改变时会调用此接口
    func mapView(_ mapView: MAMapView!, regionWillChangeAnimated animated: Bool, wasUserAction: Bool) {
        L.i("regionWillChange:\(wasUserAction) zoom:\(mapView.zoomLevel) location:\(mapView.userLocation.location)")
    }

    /// 3.
    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool, wasUserAction: Bool) {
        L.i("regionDidChange:\(wasUserAction) zoom:\(mapView.zoomLevel) location:\(mapView.userLocation.location)")
    }

    /// 点击POI 时的回调
    func mapView(_ mapView: MAMapView!, didTouchPois pois: [Any]!) {
        L.i("touch:\(pois)")
    }

    /// 点击地图回调
    func mapView(_ mapView: MAMapView!, didSingleTappedAt coordinate: CLLocationCoordinate2D) {
        L.i("tapped:\(coordinate)")

        // 点击地图, 移动到目标
        if moveToLocationOnTapped {
            mapView.setCenter(coordinate, animated: true)
        }
    }

    /// 长按地图
    func mapView(_ mapView: MAMapView!, didLongPressedAt coordinate: CLLocationCoordinate2D) {
        L.i("longPressed:\(coordinate)")
    }

}