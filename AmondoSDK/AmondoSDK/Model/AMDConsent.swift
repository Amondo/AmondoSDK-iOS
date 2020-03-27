import Foundation

struct AMDConsent: Decodable {
    var anouncements: Bool = false
    var relevant: Bool = false
    var required: Bool = true

    enum CodingKeys: String, CodingKey {
        case anouncements
        case relevant = "relevant_emails"
        case required = "required_emails"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.anouncements = try container.decode(Bool.self, forKey: .anouncements)
        self.relevant = try container.decode(Bool.self, forKey: .relevant)
        self.required = try container.decode(Bool.self, forKey: .required)
    }
}
