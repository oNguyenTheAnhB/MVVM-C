import Foundation
import UIKit

class AppCoordinator: TabbedCoordinator, Pushable {
    var window = UIWindow()
    private(set) var rootController: UIViewController

    init() {
        let repository = LoginRepository(remote: LoginRemoteDataSource())
        let viewModel = LoginViewModel(repository: repository)
        rootController = LoginViewController(viewModel: viewModel)
        super.init(tabBarController: TabBarController())
    }

    func start() {
        window.rootViewController = rootController
        window.makeKeyAndVisible()

        // TODO: This is dummy code. Please remove and write your code
        let listViewController = ListViewController()
        listViewController.title = "List"
        let controllers = [listViewController]

        tabBarController.setViewControllers(controllers, animated: false)
    }
}
