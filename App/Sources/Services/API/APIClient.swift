import UIKit
import Alamofire
import RxSwift

// MARK: - API Client
struct APIClient {

    // MARK: Private Static Variables
    private static let successRange = 200..<400
    private static let contentType = ["application/json"]

    // MARK: Static Methods

    static func call<T, V>(_ request: T, _ disposeBag: DisposeBag, onSuccess: @escaping (V) -> Void, onError: @escaping (Error) -> Void)
        where T: BaseRequestProtocol, T.ResponseType == V {

            _ = observe(request)
                .observe(on: MainScheduler.instance)
                .subscribe(onSuccess: { onSuccess($0) },
                           onFailure: { onError($0) })
                .disposed(by: disposeBag)
    }

    static func observe<T, V>(_ request: T) -> Single<V>
        where T: BaseRequestProtocol, T.ResponseType == V {

            return Single<V>.create { observer in
                let calling = callForData(request) { response in
                    switch response {
                    //swiftlint:disable force_cast
                    case .success(let result): observer(.success(result as! V))
                    case .failure(let error): observer(.failure(error))
                    //swiftlint:enable force_cast
                    }
                }

                return Disposables.create { calling.cancel() }
            }
    }

    private static func callForData<T, V>(_ request: T, completion: @escaping (APIResult) -> Void) -> DataRequest
        where T: BaseRequestProtocol, T.ResponseType == V {

            return APIClient.request(request).responseJSON { response in
                switch response.result {
                case .success(let data):
                    if let `data` = data as? Data {
                        do {
                            let result = try request.decode(data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error): completion(.failure(error))
                }
            }
    }

    private static func request<T>(_ request: T) -> DataRequest
        where T: BaseRequestProtocol {

            return AF
                .request(request)
                .validate(statusCode: successRange)
                .validate(contentType: contentType)
    }
}
