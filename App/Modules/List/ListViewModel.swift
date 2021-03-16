//
//  ListViewModel.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import Foundation
import RxSwift
import RxCocoa

class ListViewModel: ViewModelType {
    // MARK: Input
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    // MARK: Output
    struct Output {
        let fetching: Driver<Bool>
        let items: Driver<[ListItemViewModel]>
        let selectedItem: Driver<Repos>
        let error: Driver<Error>
    }
    
    private let repository: TrendingRepository
    
    init(repository: TrendingRepository) {
        self.repository = repository
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let items = input.trigger.flatMapLatest {
            return self.repository.getRepositories()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { ListItemViewModel(with: $0) } }
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedItem = input.selection
            .withLatestFrom(items) { (indexPath, reposList) -> Repos in
                return reposList[indexPath.row].repos
            }
        return Output(fetching: fetching,
                      items: items,
                      selectedItem: selectedItem,
                      error: errors)
    }
}
