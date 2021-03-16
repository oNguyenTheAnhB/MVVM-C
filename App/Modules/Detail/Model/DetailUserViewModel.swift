//
//  DetailUserViewModel.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/16/21.
//

import Foundation

class DetailUserViewModel {
    let username: String
    let avatar: String
    
    init(with user: BuiltBy) {
        avatar = user.avatar
        username = user.username
    }
}
