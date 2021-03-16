import Foundation
import UIKit

class AppCoordinator: PushedCoordinator {
    var window = UIWindow()

    func start() {
        let login = LoginCoordinator()
        let viewController = login.start()
        addChild(login)
        let navigationController = NavigationController(rootViewController: viewController)
        login.navController = navigationController

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
