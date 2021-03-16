//
//  LoginCoordinator.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import UIKit

class LoginCoordinator: PushedCoordinator {
    func start() -> UIViewController {
        let repository = LoginRepository(remote: LoginRemoteDataSource())
        let viewModel = LoginViewModel(repository: repository)
        let viewController = LoginViewController(viewModel: viewModel)
        setController(viewController)
        return viewController
    }
}
