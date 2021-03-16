//
//  LoginResponse.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/15/21.
//

import Foundation
import Alamofire

enum UserType: String, Codable {
    case user = "User"
    case organization = "Organization"
}

// MARK: - Response
struct User: Codable {
    let type: UserType
    let avartarUrl: String?
    let blog: String?
    let company: String?
    let contributions: Int?
    let email: String?
    let followers: Int?
    let following: Int?
    let htmlUrl: String?
    let location: String?
    let login: String?
    let name: String?
}
