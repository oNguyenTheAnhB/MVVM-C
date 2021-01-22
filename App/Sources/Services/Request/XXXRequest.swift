import Foundation
import Alamofire

// MARK: - Request
enum XXXRequest: BaseRequestProtocol {
    typealias ResponseType = XXXResponse

    case get

    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }

    var path: String {
        return APIConstants.xxx.path
    }

    var parameters: Parameters? {
        return nil
    }
}
