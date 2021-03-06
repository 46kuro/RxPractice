//
//  GithubSignUpUsingDriverViewController.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/02/01.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class GithubSignUpUsingDriverViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameValidationLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    @IBOutlet weak var passwordRepeatTextField: UITextField!
    @IBOutlet weak var passwordRepeatLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private var viewModel: GithubSignUpUsingDriverViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Github Signup"
        
        viewModel = GithubSignUpUsingDriverViewModel(
            input: (
                username: usernameTextField.rx.text.orEmpty.asDriver(),
                password: passwordTextField.rx.text.orEmpty.asDriver(),
                passwordRepeat: passwordRepeatTextField.rx.text.orEmpty.asDriver(),
                signUpTap: signUpButton.rx.tap.asSignal()
            ),
            dependency: (
                API: GitHubDefaultAPI.sharedAPI,
                validationService: GitHubDefaultValidationService.sharedValidationService
            )
        )
        
        viewModel.usernameResult
            .drive(usernameValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordResult
            .drive(passwordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordRepeatResult
            .drive(passwordRepeatLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        signUpButton.rx.isEnabled
    }
}
