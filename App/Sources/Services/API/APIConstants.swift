import Foundation
import Alamofire

// MARK: - Constants
enum APIConstants {
    case xxx

    // MARK: Public Variables
    var path: String {
        switch self {
        case .xxx: return "xxx"
        }
    }

    // MARK: Public Static Variables
    static var baseURL = "https://~~~"

    static var header: HTTPHeaders? {
        return nil
    }
}
