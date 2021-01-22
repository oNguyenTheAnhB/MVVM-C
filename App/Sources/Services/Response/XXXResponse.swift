import Foundation
import Alamofire

/*
 {
     "data": [
         {
             "title": "Title",
             "screen_name": "Top",
             "id": "00000",
         },
         {
             "title": "Title",
             "screen_name": "Top",
             "id": "00000",
         },
             ,
             ,
     ],
     "result": true
 }
 */

// MARK: - Response
struct XXXResponse: Codable {
    var data: [XXXModel]?
    var result: Bool = false
}

// MARK: - Model
struct XXXModel: Codable {

    let title: String?
    let screenName: String?
    let id: Int?

    enum Keys: String, CodingKey {
        case title
        case screenName
        case id
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)

        title = try container.decode(String.self, forKey: .title)
        screenName = try container.decode(String.self, forKey: .screenName)
        id = Int(try container.decode(String.self, forKey: .id))
    }
}
