//
//  GeolocationSubscriptionViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/27.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class GeolocationSubscriptionViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let service = GeolocationService.shared
        
        service.authorized
            .map{ !$0 }
            .drive(statusLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        service.location
            .drive(onNext: { [weak self] in
                self?.latLabel.text = "lat: \($0.latitude)" 
                self?.lonLabel.text = "lon: \($0.longitude)"
            })
            .disposed(by: disposeBag)
    }
}
