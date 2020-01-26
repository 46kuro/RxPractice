//
//  AddingNumbersViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/26.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AddingNumbersViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var resultLabel: UILabel!    
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adding numbers"
        
        Observable.combineLatest(textField1.rx.text.orEmpty, 
                                 textField2.rx.text.orEmpty,
                                 textField3.rx.text.orEmpty) { value1, value2, value3 -> Int in
                                    return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
}
