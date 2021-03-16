//
//  TrendingRepository.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation
import RxSwift

final class TrendingRepository: TrendingRepositoryProtocol {
    let remoteDataSource: TrendingRemoteDataSource

    init(remote: TrendingRemoteDataSource) {
        remoteDataSource = remote
    }

    func getRepositories() -> Single<[Repos]> {
        return remoteDataSource.getRepositories()
    }
}
