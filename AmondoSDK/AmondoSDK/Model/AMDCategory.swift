import Foundation

struct AMDCategory: Decodable {
    let id: Int
    let label: String
    let priority: Int
    let enabled: Bool
    let type: AMDCategoryType
    let featured: Bool
    let updatedAt: Date
    let createdBy: Int
    var genres = [AMDGenre]()
    var events = [AMDImprintItem]()

    enum CodingKeys: String, CodingKey {
        case id
        case events = "Events"
        case label
        case priority
        case enabled
        case type
        case featured
        case updatedAt
        case createdBy
        case genres
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.label = try container.decode(String.self, forKey: .label)
        self.priority = try container.decode(Int.self, forKey: .priority)
        self.enabled = try container.decode(Bool.self, forKey: .enabled)
        let type = try container.decode(String.self, forKey: .type)

        self.type = AMDCategoryType(rawValue: type)!

        self.featured = try container.decode(Bool.self, forKey: .featured)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt).dateFromPostgresString()
        self.createdBy = try container.decode(Int.self, forKey: .createdBy)
        self.genres = try container.decode([AMDGenre].self, forKey: .genres)
        self.events = try container.decode([AMDImprintItem].self, forKey: .events)
    }
}
