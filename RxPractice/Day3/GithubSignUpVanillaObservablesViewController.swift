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
                passwordRepeat: passwordRepeatTextField.rx.text.orEmpty.asObservable(),
                loginTaps: signUpButton.rx.tap.asObservable()
            ), 
            dependency: (
                API: GitHubDefaultAPI.sharedAPI,
                validationService: GitHubDefaultValidationService.sharedValidationService
            )
        )
        
        viewModel.usernameValidationResult
            .bind(to: usernameValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordValidationResult
            .bind(to: passwordValidationLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.passwordRepeatValidationResult
            .bind(to: passwordRepeatLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.signingIn
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.signedIn
            .subscribe { [weak self] in 
                guard let self = self, let element = $0.element else { return }
                let message = element ? "Mock: Signed in to GitHub." : "Mock: Sign in to GitHub failed"
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
