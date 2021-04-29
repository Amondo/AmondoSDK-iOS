//
//  AMDTeam.swift
//  AmondoSDK
//
//  Created by developer@amondo.com on 25/04/2021.
//  Copyright © 2021 Amondo. All rights reserved.
//

import Foundation

class AMDTeam: NSObject, Codable {
	var id: String? = ""
	var name: String? = ""
	var imprints: [AMDImprintItemLight]? = []
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case imprints
	}
	
	override init() {
		super.init()
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(id, forKey: .id)
		try container.encode(imprints, forKey: .imprints)
	}
	
	required init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		do {
			if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
				self.id = String(id)
			}

		} catch {
			if let stringId = try container.decodeIfPresent(String.self, forKey: .id) {
				self.id = stringId
			}
		}
		
		self.name = try container.decodeIfPresent(String.self, forKey: .name)
		
		
		if let imprints = try? container.decode([AMDImprintItemLight].self, forKey: .imprints) {
			self.imprints = imprints
		}
	}
}
