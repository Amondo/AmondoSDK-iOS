import Foundation

struct AMDEventsUsers: Codable {
    let eventId: Int
    let userId: Int
    var notify: Bool = false

    enum CodingKeys: String, CodingKey {
        case eventId = "eventId"
        case userId = "user_id"
        case notify
    }

    init(eventId: Int, userId: Int) {
        self.eventId = eventId
        self.userId = userId
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let eventId = try container.decode(Int.self, forKey: .eventId)
        self.eventId = Int(eventId)

        let userId = try container.decode(Int.self, forKey: .eventId)
        self.userId = Int(userId)

        if let notify = try? container.decode(Bool.self, forKey: .notify) {
            self.notify = notify
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(userId, forKey: .userId)
    }

    var dictionary: [String: Any] {
        var root = [String: Any]()

        root[CodingKeys.eventId.rawValue] = self.eventId
        root[CodingKeys.userId.rawValue] = self.userId

        return root
    }
}
