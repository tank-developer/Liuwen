//
//  LocationManager.swift
//  TextScan
//
//  Created by Apple on 2023/11/19.
//

// 第一步 引入api
import CoreLocation

public class LocationManager: NSObject{
    // CLLocationManager
    lazy var locationManager = CLLocationManager()
    // CLGeocoder
    lazy var gecoder = CLGeocoder()
    
    static let shared = {
           let instance = LocationManager()
           // 其他代码
           return instance
       }()
    
    private override init() {
        super.init()
        self.setupManager()
    }
    
    func setupManager() {
            // 默认情况下每当位置改变时LocationManager就调用一次代理。通过设置distanceFilter可以实现当位置改变超出一定范围时LocationManager才调用相应的代理方法。这样可以达到省电的目的。
            locationManager.distanceFilter = 300
            // 精度 比如为10 就会尽量达到10米以内的精度
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 代理
            locationManager.delegate = self
            // 第一种：能后台定位但是会在顶部出现大蓝条（打开后台定位的开关）
            // 允许后台定位
//            locationManager.allowsBackgroundLocationUpdates = true
            locationManager.requestWhenInUseAuthorization()
            // 第二种：能后台定位并且不会出现大蓝条
            // locationManager.requestAlwaysAuthorization()
        }


    func requestLocation() {
         locationManager.requestLocation()
    }
    

}

extension LocationManager: CLLocationManagerDelegate {
    // 定位成功
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // 反地理编码转换成具体的地址
            gecoder.reverseGeocodeLocation(location) { placeMarks, _ in
                // CLPlacemark －－ 国家 城市 街道
                if let placeMark = placeMarks?.first {
                    print(placeMark)
                    let Name = placeMark.addressDictionary?["Name"] as! String
                    let State = placeMark.addressDictionary?["State"] as! String
                    let SubLocality = placeMark.addressDictionary?["SubLocality"] as! String
                    let Country = placeMark.addressDictionary?["Country"] as! String
                    var address = String(format: "%@ %@%@%@", Name as! CVarArg,Country as! CVarArg,State as! CVarArg,SubLocality as! CVarArg)
                    MMKVUtil.shared.setupLocation(ele: address)
                    // print("\(placeMark.country!) -- \(placeMark.name!) -- \(placeMark.locality!)")
                }
            }
        }
        // 停止位置更新
        locationManager.stopUpdatingLocation()
    }

    // 定位失败
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        requestLocation()
    }
}

