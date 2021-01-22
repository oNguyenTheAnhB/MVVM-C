import Foundation
import RxSwift

final class XXXRepository: XXXRepositoryProtocol {
    let remoteDataSource: XXXDataSource

    init(remote: XXXDataSource) {
        remoteDataSource = remote
    }

    func getXXX() -> Single<XXXResponse> {
        return remoteDataSource.getXXX()
    }
}
