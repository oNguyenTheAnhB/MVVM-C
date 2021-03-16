//
//  LoginDataSource.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/15/21.
//

import RxSwift

protocol LoginDataSource {
    func loginWith(username: String, token: String) -> Single<User>
}
