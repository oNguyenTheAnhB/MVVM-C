//
//  DetailViewModel.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ViewModelType {
    // MARK: Input
    struct Input {
        let trigger: Driver<Void>
    }
    
    // MARK: Output
    struct Output {
        let users: Driver<[DetailUserViewModel]>
        let repos: Driver<DetailReposViewModel>
    }
    
    private let repos: Repos
    
    init(repos: Repos) {
        self.repos = repos
    }
    
    func transform(input: Input) -> Output {
        let users = input.trigger.flatMapLatest {
            return Observable<[DetailUserViewModel]>.create { (observer) -> Disposable in
                observer.onNext(self.repos.builtBy.map { DetailUserViewModel(with: $0) })
                return Disposables.create()
            }.asDriverOnErrorJustComplete()
        }
        let reposInfo = input.trigger.flatMapLatest {
            return Observable<DetailReposViewModel>.create { (observer) -> Disposable in
                observer.onNext(DetailReposViewModel(with: self.repos))
                return Disposables.create()
            }.asDriverOnErrorJustComplete()
        }
        return Output(users: users, repos: reposInfo)
    }
}
