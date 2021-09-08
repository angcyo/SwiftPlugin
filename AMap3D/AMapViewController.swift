//
// Created by angcyo on 21/09/07.
// https://lbs.amap.com/api/ios-sdk/guide/create-map/show-map

import Foundation
import UIKit
import MAMapKit

/// 高德地图界面

class AMapViewController: BaseViewController, MAMapViewDelegate {

    /// 地图组件
    let mapView: DslMapView = DslMapView()

    override func initControllerView() {
        super.initControllerView()
        initMapView()
    }

    /// 初始化组件
    func initMapView() {
        //layout
        view.render(mapView)
        mapView.make {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)

            $0.top.equalTo(navigationBarWrap?.snap.bottom ?? view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        //init style
        mapView.initView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //mapView.showsUserLocation = true
        //mapView.userTrackingMode = MAUserTrackingMode.follow
    }
}
