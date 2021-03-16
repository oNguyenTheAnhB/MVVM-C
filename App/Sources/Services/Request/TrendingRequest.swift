//
//  TrendingRequest.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation
import Alamofire

// MARK: - Request
enum TrendingRequest: BaseRequestProtocol {
    typealias ResponseType = [Repos]
    
    case get
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var path: String {
        return APIConstants.list.path
    }

    var baseURL: URL {
        return URL(string: APIConstants.trendingBaseURL)!
    }

    var parameters: Parameters? {
        return nil
    }
}
