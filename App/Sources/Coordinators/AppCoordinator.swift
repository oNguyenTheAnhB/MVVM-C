import Foundation
import UIKit

class AppCoordinator: TabbedCoordinator, Pushable {
    var window = UIWindow()

    init() {
        super.init(tabBarController: TabBarController())
    }

    func start() {
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        // TODO: This is dummy code. Please remove and write your code
        let viewController1 = ViewController()
        viewController1.view.backgroundColor = .red
        viewController1.title = "First"
        let viewController2 = ViewController()
        viewController2.view.backgroundColor = .blue
        viewController2.title = "Second"
        let viewController3 = ViewController()
        viewController3.view.backgroundColor = .green
        viewController3.title = "Three"
        let controllers = [viewController1, viewController2, viewController3]

        tabBarController.setViewControllers(controllers, animated: false)
    }
}
