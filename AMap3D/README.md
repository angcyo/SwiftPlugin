# 2021-09-07

高德3D地图

## 自动部署

https://lbs.amap.com/api/ios-sdk/guide/create-project/cocoapods

```
# 3D地图
pod 'AMap3DMap' #8.0.0

# 地位SDK
pod 'AMapLocation' #2.7.0

# 地图SDK搜索功能
pod 'AMapSearch'
```

```
Installing AMap3DMap (8.0.0)
Installing AMapFoundation (1.6.8)
Installing AMapLocation (2.7.0)
```

## 配置apiKey

> 需要在桥接文件中加入 `#import <AMapFoundationKit/AMapFoundationKit.h>`

```
AMapServices.shared().apiKey = "您的key"
```

## 声明权限

https://lbs.amap.com/api/ios-sdk/guide/create-map/location-map#location-map

> [MAMapKit] 要在iOS 11及以上版本使用定位服务, 需要在Info.plist中添加NSLocationAlwaysAndWhenInUseUsageDescription和NSLocationWhenInUseUsageDescription字段。

配置定位权限
在 Info.plist 文件中增加定位权限配置，如下图示：

值得注意的是，定位权限有三种，您可根据需求进行选择。

key | value
--|--
Privacy - Location Always Usage Description | 始终允许访问位置信息
Privacy - Location Usage Description | 永不允许访问位置信息
Privacy - Location When In Use Usage Description | 使用应用期间允许访问位置信息

```
<key>NSLocationAlwaysUsageDescription</key>
	<string>需要定位权限</string>
<key>NSLocationUsageDescription</key>
	<string>需要定位权限</string>
<key>NSLocationWhenInUseUsageDescription</key>
	<string>需要定位权限</string>
	
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>需要定位权限</string>
<key>NSLocationWhenInUseUsageDescription</key>
	<string>需要定位权限</string>
	
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true></true>
</dict>
```