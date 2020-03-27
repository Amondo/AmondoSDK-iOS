//
//  AMDGenre.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

final class AMDGenre: NSObject, Decodable {
    var name: String
    var items = [AMDImprintItem]()
    var id: Int
    var imageFile: AMDFile?

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case items = "Events"
        case id
        case imageFile = "image"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)

        self.imageFile = try container.decode(AMDFile.self, forKey: .imageFile)

        self.imageFile?.type = AMDFileType.photo

        self.items = try container.decode([AMDImprintItem].self, forKey: .items)
    }

}
