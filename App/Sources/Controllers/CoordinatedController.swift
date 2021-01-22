import UIKit

/*
 In new ViewController, basically inherit `ViewController`
 If can't inherit, do the following to ViewController
 - Adopts `CoordinatedController`
 - Add protocol `weak var weakCoordinator: Coordinator?`
 - Call `coordinator?.stop()` in `deinit`
 */
protocol CoordinatedController {
    var coordinator: Coordinator? { get set }
}
