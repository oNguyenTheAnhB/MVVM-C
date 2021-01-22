import Foundation

// MARK: - JSONDecoder Extension
extension JSONDecoder {

    convenience init(type: JSONDecoder.KeyDecodingStrategy, format: JSONDecoder.DateDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = type
        self.dateDecodingStrategy = format
    }

    static var decoder: JSONDecoder = JSONDecoder(type: .convertFromSnakeCase, format: .iso8601)
}
