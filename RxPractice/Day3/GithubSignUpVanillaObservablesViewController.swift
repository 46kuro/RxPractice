//
//  GithubSignUpVanillaObservablesViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/30.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class GithubSignUpVanillaObservablesViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var passwordRepeatTextField: UITextField!
    @IBOutlet weak var passwordRepeatLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: GithubSignUpVanillaObservablesViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GitHub Signup"
        
        viewModel = GithubSignUpVanillaObservablesViewModel(
            input: (
                username: usernameTextField.rx.text.orEmpty.asObservable(),
                password: passwordTextField.rx.text.orEmpty.asObservable(),
                passwordRepeat: passwordRepeatTextField.rx.text.orEmpty.asObservable() 
            )
        )
        
        viewModel.usernameValidationResult
            .bind(to: usernameValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordValidationResult
            .bind(to: passwordRepeatLabel.rx.validationResult)
            .disposed(by: disposeBag)
    }
}
