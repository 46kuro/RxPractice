//
//  GeolocationSubscriptionViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/27.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import CoreLocation
import RxCocoa
import RxSwift
import UIKit

class GeolocationSubscriptionViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
}

extension GeolocationSubscriptionViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            guard let lat = manager.location?.coordinate.latitude, 
                let lon = manager.location?.coordinate.longitude else { return }
            latLabel.text = "lat: \(lat)"
            lonLabel.text = "lon: \(lon)"
            break
        case .denied, .restricted:
            break
        @unknown default:
            fatalError()
        }
    }
}
