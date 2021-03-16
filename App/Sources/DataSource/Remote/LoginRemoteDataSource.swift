//
//  LoginRemoteDataSource.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/15/21.
//

import Foundation
import RxSwift

final class LoginRemoteDataSource: LoginDataSource {
    func loginWith(username: String, token: String) -> Single<User> {
        return APIClient.observe(LoginRequest.get(username: username, token: token))
    }
}
