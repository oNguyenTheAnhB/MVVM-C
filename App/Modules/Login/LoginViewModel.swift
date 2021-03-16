//
//  LoginViewModel.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: ViewModelType {
    // MARK: Input
    struct Input {
        let username: Driver<String>
        let token: Driver<String>
        let loginButtonTapped: Driver<Void>
    }
    
    // MARK: Output
    struct Output {
        let loading: Driver<Bool>
        let user: Driver<User>
        let error: Driver<Error>
    }
    
    private let repository: LoginRepository
    
    init(repository: LoginRepository) {
        self.repository = repository
    }

    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let usernameAndToken = Driver.combineLatest(input.username, input.token)
        let user = input.loginButtonTapped
            .withLatestFrom(usernameAndToken)
            .filter { (username, token) -> Bool in
                return username.count > 0 && token.count > 0
            }
            .flatMapLatest { (username, token) in
                return self.repository.loginWith(username: username, token: token)
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            }
        
        let loading = activityIndicator.asDriver()
        let error = errorTracker.asDriver()

        return Output(loading: loading, user: user, error: error)
    }
}
