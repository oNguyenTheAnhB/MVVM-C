//
//  ListCoordinator.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import UIKit

class ListCoordinator: PushedCoordinator {
    func start() {
        let repository = TrendingRepository(remote: TrendingRemoteDataSource())
        let viewModel = ListViewModel(repository: repository)
        let viewController = ListViewController(viewModel: viewModel)
        showController(viewController, animated: true)
    }
}
