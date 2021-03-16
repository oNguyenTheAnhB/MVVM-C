//
//  TrendingDataSource.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import RxSwift

protocol TrendingDataSource {
    func getRepositories() -> Single<[Repos]>
}
