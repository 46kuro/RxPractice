//
//  GithubSignUpUsingDriverViewModel.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/02/01.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class GithubSignUpUsingDriverViewModel {
    
    private(set) var usernameResult: Driver<ValidationResult>
    private(set) var passwordResult: Driver<ValidationResult>
    private(set) var passwordRepeatResult: Driver<ValidationResult>
    private(set) var signUpButtonEnabled: Driver<Bool>
    
    init(
        input: (
            username: Driver<String>,
            password: Driver<String>,
            passwordRepeat: Driver<String>,
            signUpTap: Signal<Void>
        ),
        dependency: (
            API: GitHubAPI,
            validationService: GitHubValidationService
        )
    ) {
        usernameResult = input.username
            .flatMapLatest {
                dependency.validationService
                    .validateUsername($0)
                    .asDriver(onErrorJustReturn: .failed(message: "Error contacting server"))
            }
        
        passwordResult = input.password
            .map {
                dependency.validationService
                    .validatePassword($0)
            }
            .asDriver()
        
        passwordRepeatResult = Driver.combineLatest(input.password, input.passwordRepeat) {
            dependency.validationService.validateRepeatedPassword($0, repeatedPassword: $1)
        }
        .asDriver()
        
        signUpButtonEnabled = Driver.combineLatest(usernameResult, passwordResult, passwordRepeatResult)
            .map { $0.0.isValid && $0.1.isValid && $0.2.isValid }
            .distinctUntilChanged()
    }
}
