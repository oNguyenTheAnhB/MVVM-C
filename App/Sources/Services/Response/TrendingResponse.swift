//
//  TrendingResponse.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation

struct Repos: Codable {
    let author: String
    let name: String
    let avatar: String
    let description: String
    let url: String
    let language: String?
    let stars: Int
    let forks: Int
    let builtBy: [BuiltBy]
}

struct BuiltBy: Codable {
    let username: String
    let avatar: String
}
