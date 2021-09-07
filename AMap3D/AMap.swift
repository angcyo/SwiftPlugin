//
// Created by angcyo on 21/09/07.
// #import <AMapFoundationKit/AMapFoundationKit.h>
// https://lbs.amap.com/api/ios-sdk/guide/create-project/foundation-sdk

import Foundation
import AMapFoundationKit

class AMap {

    static var API_KEY: String = ""

    /// 地图默认缩放级别
    static var DEF_ZOOM_LEVEL: CGFloat = 15

    static func initAMap(_ key: String) {
        AMap.API_KEY = key

        /// https https://lbs.amap.com/api/ios-sdk/guide/create-project/https-guide
        AMapServices.shared().enableHTTPS = true

        AMapServices.shared().apiKey = key
    }
}