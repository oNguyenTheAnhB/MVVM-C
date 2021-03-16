//
//  ListItemViewModel.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation

class ListItemViewModel {
    let name: String
    let avatar: String
    let summary: String
    let other: String
    let repos: Repos
    
    init(with repos: Repos) {
        self.repos = repos
        avatar = repos.avatar
        name = repos.name
        summary = repos.description
        other = "Star:\(repos.stars) Fork:\(repos.forks)"
    }
}
