import Foundation

// MARK: - ResultType
enum APIResult {
    case success(Codable)
    case failure(Error)
}
