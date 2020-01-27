//
//  SimpleValidationViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/26.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class SimpleValidationViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameAnnotationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAnnotationLabel: UILabel!
    @IBOutlet weak var doSomethingButton: UIButton!
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Simple validation"
        
        let usernameMap = usernameTextField.rx.text.orEmpty
            .map { $0.count >= 5 }
            .share(replay: 1)
        
        usernameMap
            .bind(to: usernameAnnotationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        let passwordMap = passwordTextField.rx.text.orEmpty.map { $0.count >= 5 }
            .share(replay: 1)
        
        passwordMap
            .bind(to: passwordAnnotationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(usernameMap, passwordMap)
            .map { return $0 && $1 }
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        doSomethingButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let alert = UIAlertController(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
