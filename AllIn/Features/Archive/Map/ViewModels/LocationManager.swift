//
//  LocationManager.swift
//  AllIn
//
//  Created by KimDogyung on 7/23/25.
//

import CoreLocation


// Delegate에서 구현해야할 최소 세가지 (이것들은 구현해야함)
//1.    권한 변경 → didChangeAuthorization
//2.    위치 업데이트 → didUpdateLocations
//3.    오류 처리 → didFailWithError

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastLocation: CLLocation?
    
    let manager = CLLocationManager()
    
    
    override init() {
        self.authorizationStatus = manager.authorizationStatus
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // 사용 중 허용되면 위치 업데이트 시작
            manager.startUpdatingLocation()
            // 2) 그리고 나서 '항상' 권한을 요청
//            manager.requestAlwaysAuthorization()
            
        case .authorizedAlways:
            // 백그라운드 포함 항상 허용된 상태
            manager.startUpdatingLocation()
            
        default:
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        // 가장 최근 위치를 published
        lastLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
    }
    
    
}
