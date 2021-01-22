import UIKit
import RxSwift
import XCGLogger

let log: XCGLogger? = {
    #if DEBUG
        let log = XCGLogger.default
        let systemDestination = AppleSystemLogDestination(identifier: "app.systemDestination")
        systemDestination.showLogIdentifier = false
        systemDestination.showFileName = true
        systemDestination.showFunctionName = true
        systemDestination.showLineNumber = true
        systemDestination.showDate = true
        systemDestination.outputLevel = .verbose
        log.add(destination: systemDestination)
        return log
    #else
        return nil
    #endif
}()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start()
        return true
    }
}
