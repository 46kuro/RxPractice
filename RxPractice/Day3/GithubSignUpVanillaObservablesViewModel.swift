//
//  GithubSignUpVanillaObservablesViewModel.swift
//  RxPractice
//
//  Created by Shinji Kurosawa on 2020/01/30.
//  Copyright © 2020 Shinji Kurosawa. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class GithubSignUpVanillaObservablesViewModel {
    
    // MARK: output
    private(set) var usernameValidationResult: Observable<ValidationResult>
    private(set) var passwordValidationResult: Observable<ValidationResult>
    private(set) var passwordRepeatValidationResult: Observable<ValidationResult>
    private(set) var signedIn: Observable<Bool>
    private(set) var signingIn: Observable<Bool>
    private(set) var signUpButtonEnabled: Observable<Bool>
    
    init(input: (
            username: Observable<String>, 
            password: Observable<String>, 
            passwordRepeat: Observable<String>,
            loginTaps: Observable<Void> 
        ), 
        dependency: (
            API: GitHubAPI, 
            validationService: GitHubValidationService
        )
    ) {
        usernameValidationResult = input.username
            .flatMapLatest { 
                return dependency.validationService
                    .validateUsername($0)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "Error contacting server"))
            }
            .share(replay: 1)
        
        passwordValidationResult = input.password
            .map {
                dependency.validationService.validatePassword($0)
            }
            .share(replay: 1)
        
        passwordRepeatValidationResult = Observable.combineLatest(
            input.password, input.passwordRepeat,
            resultSelector: dependency.validationService.validateRepeatedPassword
        )
            .share(replay: 1)
        
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asObservable()
        
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest {
                return dependency.API.signup($0.username, password: $0.password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(false)
                    .trackActivity(signingIn)
            }
            .share(replay: 1)
        
        signUpButtonEnabled = Observable.combineLatest(usernameValidationResult,
                                                       passwordValidationResult,
                                                       passwordRepeatValidationResult)
            .map { $0.0.isValid && $0.1.isValid && $0.2.isValid }
            .distinctUntilChanged()
            .share(replay: 1)
    }
}
