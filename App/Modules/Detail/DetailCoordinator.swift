//
//  DetailCoordinator.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import UIKit

class DetailCoordinator: PushedCoordinator {
    func start(with repos: Repos) {
        let viewModel = DetailViewModel(repos: repos)
        let viewController = DetailViewController(viewModel: viewModel)
        showController(viewController, animated: true)
    }
}
