//
//  DetailReposViewModel.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation

class DetailReposViewModel {
    let name: String
    let avatar: String
    let summary: String
    let stars: Int
    let forks: Int
    let language: String?
    
    init(with repos: Repos) {
        avatar = repos.avatar
        name = repos.name
        summary = repos.description
        stars = repos.stars
        forks = repos.forks
        language = repos.language
    }
}
