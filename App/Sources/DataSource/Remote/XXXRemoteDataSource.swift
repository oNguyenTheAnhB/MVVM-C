import Foundation
import RxSwift

final class XXXRemoteDataSource: XXXDataSource {
    func getXXX() -> Single<XXXResponse> {
        return APIClient.observe(XXXRequest.get)
    }
}
