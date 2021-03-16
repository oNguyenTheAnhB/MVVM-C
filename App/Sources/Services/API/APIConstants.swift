import Foundation
import Alamofire

// MARK: - Constants
enum APIConstants {
    case xxx
    case login

    // MARK: Public Variables
    var path: String {
        switch self {
        case .xxx: return "xxx"
        case .login: return "user"
        }
    }

    // MARK: Public Static Variables
    static var baseURL = "https://api.github.com"

    static var header: HTTPHeaders? {
        return nil
    }
}
