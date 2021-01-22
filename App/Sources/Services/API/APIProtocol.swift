import Foundation
import Alamofire

// MARK: - Base API Protocol
protocol BaseAPIProtocol {
    associatedtype ResponseType: Codable

    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var decode: (Data) throws -> ResponseType { get }
}

extension BaseAPIProtocol {

    var baseURL: URL {
        //swiftlint:disable force_try
        return try! APIConstants.baseURL.asURL()
        //swiftlint:enable force_try
    }

    var headers: HTTPHeaders? {
        return APIConstants.header
    }

    var decode: (Data) throws -> ResponseType {
        return { try JSONDecoder.decoder.decode(ResponseType.self, from: $0) }
    }
}

// MARK: - BaseRequestProtocol
protocol BaseRequestProtocol: BaseAPIProtocol, URLRequestConvertible {
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

extension BaseRequestProtocol {
    var encoding: URLEncoding {
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))

        urlRequest.httpMethod = method.rawValue

        urlRequest.allHTTPHeaderFields = headers?.dictionary

        urlRequest.timeoutInterval = TimeInterval(30)

        if let params = parameters {
            urlRequest = try encoding.encode(urlRequest, with: params)
        }

        return urlRequest
    }
}
