//
//  TrendingRemoteDataSource.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation
import RxSwift

final class TrendingRemoteDataSource: TrendingDataSource {
    func getRepositories() -> Single<[Repos]> {
        return APIClient.observe(TrendingRequest.get)
    }
}
