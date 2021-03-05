import UIKit

// All ViewControllers should inherit this class.
class ViewController: UIViewController {
    weak var weakCoordinator: Coordinator?

    deinit {
        weakCoordinator?.stop()
    }
}

extension ViewController: CoordinatedController {
    var coordinator: Coordinator? {
        get {
            return weakCoordinator
        } set(coordinator) {
            weakCoordinator = coordinator
        }
    }

    func pushableCoordinator() -> (Coordinator & Pushable)? {
        if let pushable = coordinator as? (Coordinator & Pushable) {
            return pushable
        }
        assertionFailure("This coordinator has not adopted `Pushable` in \(String(describing: self)). Don't use pushable in this controller.")
        return nil
    }
}
