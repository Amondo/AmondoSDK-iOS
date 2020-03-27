import Foundation

struct AMDTokenResponse: Decodable {
    var token: String?
    var message: String?

    enum CodingKeys: String, CodingKey {
        case token
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let token = try? container.decode(String.self, forKey: .token) {
            self.token = token
        }

        if let message = try? container.decode(String.self, forKey: .message) {
            self.message = message
        }
    }
}
