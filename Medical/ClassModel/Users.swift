//
//  Users.swift
//  Medical
//
//  Created by 于争光 on 2021/10/4.
//

import Foundation
import CoreData
import MapKit
import CoreLocation

class UsersModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    static var shaer = UsersModel()
    
    @Published var places: String = ""
    
    @Published var latLog: CLLocationCoordinate2D!
    
    @Published var permissionDenied = false
    
    @Published var manager: CLLocationManager = CLLocationManager()
    
    // TabView Active
    @Published var activeBar: Tab = .Home
    
    @Published var currentXValue: CGFloat = 0
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied:
            permissionDenied.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        
        let geo = CLGeocoder()
        
        geo.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { placemark, error in
            guard let placemarks = placemark?.first else{ return }
            
            guard let name = placemarks.locality else{ return }
            
            let coordinates = placemarks.location?.coordinate
            
            DispatchQueue.main.async {
                self.latLog = coordinates
                self.places = name
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // 储存
    func setNormalDefault(key: String,val: Any?) {
        if val == nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        UserDefaults.standard.setValue(val, forKey: key)
        UserDefaults.standard.synchronize()
    }
    // 通过对应的key移除储存
    func removeDeafult(key: String?) {
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    // 取值
    func getNormalDefult(key: String?) -> Any? {
        return UserDefaults.standard.value(forKey: key ?? "") as AnyObject
    }
}
