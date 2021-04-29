//
//  Event.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import AVKit

class AMDEvent: Decodable {
    var id: String!
	var publicId: String?
    var artist: String?
    var location: String?
    var slug: String?
    var date: Date?
    var local: Bool = true
    var avPlayer: AVPlayer?
    var object: [String: Any]?
    var image: UIImage?
    var geoPoint = AMDGeoPoint.zero
    var locationRadius: Double?

    class func setCurrentEvent(_ eventID: String, date: Date) {
        let def = UserDefaults.standard
        def.setValue(eventID, forKey: "AMDEVENT-currentEventID")
        def.setValue(date, forKey: "AMDEVENT-currentEventDate")
        def.synchronize()
    }

    class func retrieveCurrentEvent() -> (String?, String?) {
        let def = UserDefaults.standard
        let id = def.value(forKey: "AMDEVENT-currentEventID") as? String
        let date = def.value(forKey: "AMDEVENT-currentEventDate") as? String
        return (id, date)
    }

    enum CodingKeys: String, CodingKey {
        case id
		case publicId
        case location
        case artist
        case startDate
        case geoPoint
        case locationRadius
        case slug
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
		
		do {
			if let publicId = try container.decodeIfPresent(Int.self, forKey: .publicId) {
				self.publicId = String(publicId)
			}

		} catch {
			if let stringId = try container.decodeIfPresent(String.self, forKey: .publicId) {
				self.publicId = stringId
			}
		}
        
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)
        self.location = try container.decodeIfPresent(String.self, forKey: .location)
        self.artist = try container.decodeIfPresent(String.self, forKey: .artist)

        if let date = try container.decodeIfPresent(String.self, forKey: .startDate) {
            self.date = date.dateFromPostgresString()
        }
        

        if let point = try container.decodeIfPresent([Double].self, forKey: .geoPoint) {
            self.geoPoint = AMDGeoPoint(points: point)
        }

        self.locationRadius = try container.decodeIfPresent(Double.self, forKey: .locationRadius)
    }

    required init() {}
}
