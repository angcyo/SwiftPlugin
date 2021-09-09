//
// Created by angcyo on 21/09/09.
//

import Foundation

/// 地图 放大/缩小, 自己的位置. 视图封装

class AMapControlView: BaseUIView {

    /// 放大
    let zoomIn = fitImageView(R.image.icon_map_zoom_in())

    /// 缩小
    let zoomOut = fitImageView(R.image.icon_map_zoom_out())

    let gpsMy = fitImageView(R.image.icon_map_gps_my())

    let iconSize: CGFloat = 37

    /// 地图视图
    var mapView: DslMapView? = nil

    override func initView() {
        super.initView()

        render(zoomIn)
        render(zoomOut)
        render(gpsMy)

        with(zoomIn) {
            $0.makeGravityLeft()
            $0.makeGravityTop()
            $0.makeGravityRight()
            $0.makeWidthHeight(size: iconSize)
        }
        with(zoomOut) {
            $0.makeGravityLeft()
            $0.makeTopToBottomOf(zoomIn)
            $0.makeGravityRight()
            $0.makeWidthHeight(size: iconSize)
        }
        with(gpsMy) {
            $0.makeGravityLeft()
            $0.makeTopToBottomOf(zoomOut, offset: 16)
            $0.makeGravityRight()
            $0.makeGravityBottom(priority: .medium)
            $0.makeWidthHeight(size: iconSize)
        }

        //手势
        initGesture()
    }

    func initGesture() {
        resetGesture()
        //放大
        zoomIn.onClick(bag: gestureDisposeBag) { _ in
            if let mapView = self.mapView {
                let oldZoom = mapView.zoomLevel
                mapView.setZoomLevel(oldZoom + 1, animated: true)
            }
        }
        //缩小
        zoomOut.onClick(bag: gestureDisposeBag) { _ in
            if let mapView = self.mapView {
                let oldZoom = mapView.zoomLevel
                mapView.setZoomLevel(oldZoom - 1, animated: true)
            }
        }
        //我的位置
        gpsMy.onClick(bag: gestureDisposeBag) { _ in
            if let mapView = self.mapView {
                if let location = mapView.userLocation.location, mapView.userLocation.isUpdating {
                    mapView.setCenter(location.coordinate, animated: true)
                    mapView.setZoomLevel(AMap.DEF_ZOOM_LEVEL, animated: true)
                }
            }
        }
    }
}