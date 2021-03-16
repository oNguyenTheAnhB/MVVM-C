import RxSwift

protocol XXXRepositoryProtocol {
    func getXXX() -> Single<XXXResponse>
}

protocol LoginRepositoryProtocol {
    func loginWith(username: String, token: String) -> Single<User>
}
