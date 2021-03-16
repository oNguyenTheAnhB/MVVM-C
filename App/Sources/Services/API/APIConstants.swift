import Foundation
import Alamofire

// MARK: - Constants
enum APIConstants {
    case xxx
    case login
    case list

    // MARK: Public Variables
    var path: String {
        switch self {
        case .xxx: return "xxx"
        case .login: return "user"
        case .list: return "repositories"
        }
    }

    // MARK: Public Static Variables
    static var baseURL = "https://api.github.com"
    static var trendingBaseURL = "https://gtrending.yapie.me"

    static var header: HTTPHeaders? {
        return nil
    }
}
