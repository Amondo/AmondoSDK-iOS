//
//  AMDFile.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

final class AMDFile: NSObject, Codable {

    var url: String!
    var publicID: String?
    var type: AMDFileType!
    var cached: Bool = false
    var cacheUrl: URL!
    var width: Int = 300
    var height: Int = 300
    var format: String!
    var version: Int!
    var loading = false

    var quality: Int = 100 {
        didSet {
            if quality > 100 {
                quality = 100
            }
        }
    }

    var corrupted = false

    convenience init(file: [String: Any], ftype: String) {
        self.init()

        if let url = file["url"] as? String {
            self.url = url
        } else {
            self.url = file["secureUrl"] as? String
            if self.url == nil {
                self.corrupted = true
                return
            }
        }

        self.publicID = file["public_id"] as? String
        if self.publicID == nil {
            self.publicID = file["publicId"] as? String
        }
        self.format = file["format"] as? String
        self.version = file["version"] as? Int

        self.type = AMDFileType(rawValue: ftype)

        if self.type != .icon {
            self.cacheUrl = self.cacheURLConstructor()
            self.cached = checkDoesCacheExist()
        }
    }

    enum CodingKeys: String, CodingKey {
        case url
        case publicID = "public_id"
        case type
        case format
        case version
        case height
        case width
        case publicID2 = "publicId"
    }

    override init() {
        super.init()
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.url = try container.decode(String.self, forKey: .url)
        self.publicID = try container.decodeIfPresent(String.self, forKey: .publicID)
        if self.publicID == nil {
            do {
                self.publicID = try container.decodeIfPresent(String.self, forKey: .publicID2)
            } catch {
            
            }
        }
        self.format = try container.decode(String.self, forKey: .format)
        self.version = try container.decode(Int.self, forKey: .version)
        self.height = try container.decode(Int.self, forKey: .height)
        self.width = try container.decode(Int.self, forKey: .width)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(publicID, forKey: .publicID)
        try container.encode(format, forKey: .format)
        try container.encode(version, forKey: .version)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
    }

    var dictionary: [String: Any] {
        var root = [String: Any]()

        root[CodingKeys.url.rawValue] = self.url
        root[CodingKeys.publicID.rawValue] = self.publicID
        root[CodingKeys.format.rawValue] = self.format
        root[CodingKeys.type.rawValue] = self.type.rawValue
        root[CodingKeys.version.rawValue] = self.version
        root[CodingKeys.publicID.rawValue] = self.publicID
        root[CodingKeys.width.rawValue] = self.width
        root[CodingKeys.height.rawValue] = self.height

        return root
    }
}
