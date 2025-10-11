//
//  LocationManager.swift
//  Pods
//
//  Created by Lokesh N on 11/10/25.
//


import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var completionHandler: ((String) -> Void)?

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestAuthorization(completion: @escaping (String) -> Void) {
        self.completionHandler = completion
        manager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var result: String

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            result = "granted"
        case .denied, .restricted:
            result = "denied"
        case .notDetermined:
            result = "notDetermined"
        @unknown default:
            result = "unknown"
        }

        completionHandler?(result)
        completionHandler = nil
    }
}
