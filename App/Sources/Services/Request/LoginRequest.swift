//
//  LoginRequest.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/15/21.
//

import Foundation
import Alamofire

// MARK: - Request
enum LoginRequest: BaseRequestProtocol {
    typealias ResponseType = User
    
    case get(username: String, token: String)
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var path: String {
        return APIConstants.login.path
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case let .get(username, token):
            return [.authorization("Basic " + "\(username):\(token)".toBase64())]
        }
    }
}
