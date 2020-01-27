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
        
        usernameTextField.rx.text.orEmpty.map { username in
            return username.count >= 5
        }
        .bind(to: usernameAnnotationLabel.rx.isHidden)
        .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.map { passwordTextField in
            return passwordTextField.count >= 5
        }
        .bind(to: passwordAnnotationLabel.rx.isHidden)
        .disposed(by: disposeBag)
        
        Observable.combineLatest(usernameTextField.rx.text.orEmpty, passwordTextField.rx.text.orEmpty)
            .map({ username, password in 
                return username.count >= 5 && password.count >= 5
            })
            .bind(to: doSomethingButton.rx.isEnabled)
            .disposed(by: disposeBag)
        doSomethingButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                let alert = UIAlertController(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
