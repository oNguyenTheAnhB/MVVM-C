import UIKit

class TabbedCoordinator: Coordinator {
    let tabBarController: UITabBarController
    var controllers: [UIViewController] = []

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
}
