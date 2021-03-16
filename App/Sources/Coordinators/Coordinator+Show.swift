import UIKit
import RxSwift

// MARK: - Show other screen
extension Coordinator {
    func showList() {
        let child = ListCoordinator()
        addChild(child)
        child.start()
    }
    
    func showDetail(with repos: Repos) {
        let child = DetailCoordinator()
        addChild(child)
        child.start(with: repos)
    }
}

// MARK: - Show child by present
extension Coordinator {
    
}

// MARK: - Show modal
extension Coordinator {
    
}

// MARK: - Show child by push
extension Coordinator {
    
}
