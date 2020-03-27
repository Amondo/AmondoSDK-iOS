import Foundation

struct AMDConsentMeta: Decodable {
    var id: Int
    var userId: Int
    var consent: AMDConsent
    var createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case consent = "consent"
        case createdAt
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.createdAt = try container.decode(String.self, forKey: .createdAt).dateFromPostgresString()

        self.consent = try container.decode(AMDConsent.self, forKey: .consent)
    }
}
