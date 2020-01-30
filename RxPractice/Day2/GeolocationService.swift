//
//  GeolocationService.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/27.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import CoreLocation
import Foundation
import RxCocoa
import RxSwift

class GeolocationService {
    
    static let shared = GeolocationService()
    private let locationManager = CLLocationManager()
    
    private (set) var authorized: Driver<Bool>
    private (set) var location: Driver<CLLocationCoordinate2D>
    
    private init() {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        authorized = Observable.deferred { [weak locationManager] in
            let status = CLLocationManager.authorizationStatus()
            guard let locationManager = locationManager else {
                return Observable.just(status)
            }
            return locationManager
                .rx.didChangeAuthorizationStatus
                .startWith(status)
        }
        .asDriver(onErrorJustReturn: CLAuthorizationStatus.notDetermined)
        .map({
            switch $0 {
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            default:
                return false
            }
        })
        
        location = locationManager.rx.didUpdateLocations
            .asDriver(onErrorJustReturn: [])
            .flatMap {
                return $0.last.map(Driver.just) ?? Driver.empty()
            }
            .map { $0.coordinate }
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
