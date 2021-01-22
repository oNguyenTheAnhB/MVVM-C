import Foundation
import UIKit

/*
 If make new screen, make new `Coordinator` class too.
 - New `Coordinator` should inherit one of the following classes.
    - `PushedCoordinator` : Use to screen that open by `pushViewController` method.
    - `PresentedCoordinator` : Use to screen that open by `present` method.
    - `PresentedCoordinator, Pushable` : Use to screen that open by `present` method and can open new screen by `pushViewController` method..
 - Implement `start` method in new `Coordinator` class.
 - Call `showController` method in `start` method.
 - Add the show method to `Coordinator+Show.swift`.

 Coordinators must not have strong references.
 Because if ViewController has memory leak, a memory leak of the `Coorinator` also occurs.
 */
class Coordinator: NSObject {

    internal weak var navController: UINavigationController?
    fileprivate weak var viewController: (UIViewController & CoordinatedController)?
    fileprivate weak var parentCoordinator: Coordinator?

    /*
     `childCoordinators` is used for retain of child coordinator.
     Don't use `childCoordinators` for search child screen.
     Because if `ViewController` has memory leak,
     coordinator of closed screen is remaining in `childCoordinators`.
     */
    private var childCoordinators: [Coordinator] = []

    internal func addChild(_ child: Coordinator) {
        childCoordinators.append(child)
        child.parentCoordinator = self
    }

    fileprivate func removeChild(_ child: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === child }) else { return }
        childCoordinators.remove(at: index)
    }

    internal func presenterForChild() -> UIViewController {
        guard var presenter: UIViewController = navController ?? viewController else {
            assertionFailure("Already released the viewController in \(String(describing: self)).")
            // should not enter here,
            // if you are trying to use AppDelegate.appCoordinator to show something,
            // please use AppDelegate.appCoordinator.selectedChild Coordinator
            return UIViewController()
        }
        while let presented = presenter.presentedViewController, !presented.isBeingDismissed {
            presenter = presented
        }
        return presenter
    }

    internal func setController(_ controller: UIViewController & CoordinatedController) {
        viewController = controller
        viewController?.coordinator = self
    }

    func stop() {
        parentCoordinator?.removeChild(self)
    }

    func getParent() -> Coordinator? {
        return parentCoordinator
    }

    func getViewController() -> UIViewController? {
        return viewController ?? nil
    }
}

class PresentedCoordinator: Coordinator {

    internal func showController(_ controller: UIViewController & CoordinatedController,
                                 animated: Bool,
                                 completion: (() -> Void)? = nil) {
        #if DEBUG
        if self is Pushable {
            // Detect the wrong implementation
            fatalError("Delete `Pushable` from \(String(describing: self)) or call showController(_:shownNavController:animated:completion)")
        }
        #endif
        guard let presenter = parentCoordinator?.presenterForChild() else {
            assertionFailure("`parentCoordinator` is nil`.  \(String(describing: self)).")
            return
        }
        setController(controller)
        presenter.present(controller, animated: animated, completion: completion)
    }

    func showAlert(_ controller: UIAlertController,
                   animated: Bool,
                   completion: (() -> Void)? = nil) {
        #if DEBUG
        if self is Pushable {
            // Detect the wrong implementation
            fatalError("Delete `Pushable` from \(String(describing: self)) or call showController(_:shownNavController:animated:completion)")
        }
        #endif
        guard let presenter = parentCoordinator?.presenterForChild() else {
            assertionFailure("`parentCoordinator` is nil`.  \(String(describing: self)).")
            return
        }
        presenter.present(controller, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool) {
        viewController?.dismiss(animated: animated, completion: nil)
    }
}

extension Pushable where Self: PresentedCoordinator {
    internal func showController(_ controller: UIViewController & CoordinatedController,
                                 shownNavController: UINavigationController,
                                 animated: Bool,
                                 completion: (() -> Void)? = nil) {
        guard let presenter = parentCoordinator?.presenterForChild() else {
            assertionFailure("`parentCoordinator` is nil`.  \(String(describing: self)).")
            return
        }
        setController(controller)
        navController = shownNavController
        presenter.present(shownNavController, animated: animated, completion: completion)
    }
}

class PushedCoordinator: Coordinator, Pushable {

    internal func showController(_ controller: UIViewController & CoordinatedController,
                                 animated: Bool) {
        guard let pushable = parentCoordinator as? Pushable else {
            assertionFailure("`parentCoordinator` is not `Pushable`.  \(String(describing: parentCoordinator)).")
            return
        }
        let nav = pushable.navForChild()
        if nav.viewControllers.first != nil {
            controller.hidesBottomBarWhenPushed = true
        }
        setController(controller)
        self.navController = nav
        nav.pushViewController(controller, animated: animated)
    }
}

protocol Pushable: AnyObject {
    func navForChild() -> UINavigationController
}

extension Pushable where Self: Coordinator {
    internal func navForChild() -> UINavigationController {
        if let nav = navController {
            return nav
        }
        assertionFailure("Already released the navController in \(String(describing: self)).")
        return UINavigationController()
    }
}
