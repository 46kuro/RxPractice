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
    
    private(set) var usernameValidationResult: Observable<ValidationResult>
    private(set) var passwordValidationResult: Observable<ValidationResult>
    private(set) var passwordRepeatValidationResult: Observable<ValidationResult>
    
    init(input: (
            username: Observable<String>, 
            password: Observable<String>, 
            passwordRepeat: Observable<String>
        )) {
        let api = GitHubDefaultAPI.sharedAPI
        usernameValidationResult = input.username
            .flatMapLatest { 
                return GitHubDefaultValidationService.sharedValidationService
                    .validateUsername($0)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "Error contacting server"))
            }
            .share(replay: 1)
        
        passwordValidationResult = input.password
            .map {
                GitHubDefaultValidationService.sharedValidationService
                    .validatePassword($0)
            }
            .share(replay: 1)
        
        passwordRepeatValidationResult = Observable.combineLatest(
            input.password, input.passwordRepeat,
            resultSelector: GitHubDefaultValidationService.sharedValidationService.validateRepeatedPassword
        )
            .share(replay: 1)
    }
}
