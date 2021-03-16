//
//  LoginRepository.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/15/21.
//

import Foundation
import RxSwift

final class LoginRepository: LoginRepositoryProtocol {
    let remoteDataSource: LoginDataSource

    init(remote: LoginDataSource) {
        remoteDataSource = remote
    }

    func loginWith(username: String, token: String) -> Single<User> {
        return remoteDataSource.loginWith(username: username, token: token)
    }
}
