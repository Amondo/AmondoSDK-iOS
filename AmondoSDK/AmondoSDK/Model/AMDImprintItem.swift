//
//  ImprintItem.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/26/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import Alamofire

var curatedAssets = [AMDAsset]()

public class AMDImprintItem: NSObject, Decodable {

    enum Status: String {
        case hidden
        case upcoming
        case active
    }
    
    var grid: GridTemplate?
    var event: AMDEvent?
    var type: String!
    var slug: String?
    var cd: SavedImprint?

    var object: [String: Any]?
    var image: UIImage?
    var imageMeta: AMDFile?
    var loaded = false
    var items = [AMDAsset]()
    var deviceAssets = [(AMDAsset, Bool, Bool)]()
    var loadingPercent: Float = 0.0

    var avPlayer: AVPlayer?

    var loading = false
    var upcoming = true
    var status: Status? = .hidden
    var notified = false
    var liked: Bool = false
    var contributed = false
    var contributedAssetsCount = 0

    var startDate = Date()
    var endDate = Date()

    var dataRequests = [DataRequest?]()

    func objectID() -> String {
        return event!.id
    }

    var owner: UIViewController!

    override init() {
        super.init()
    }

    enum CodingKeys: String, CodingKey {
        case status
        case id
        case artist
        case slug
        case endDate
        case startDate
        case image
        case location
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let decodedStatus = try container.decodeIfPresent(String.self, forKey: .status) {
            if let stat = Status(rawValue: decodedStatus) {
                self.status = stat
            } else {
                self.status = .hidden
            }
        }
        
        self.slug = try container.decodeIfPresent(String.self, forKey: .slug)

        do {
            let event = try AMDEvent(from: decoder)

            self.event = event
        } catch {
            let event = AMDEvent()
            event.id = try container.decodeIfPresent(String.self, forKey: .id)
            event.artist = try container.decode(String.self, forKey: .artist)
            event.location = try container.decode(String.self, forKey: .location)
            self.event = event
        }


        if let user = AMDUser.currentUser(), let eventId = event?.id {
            self.liked = user.events_users.contains(eventId)
            self.contributed = user.contributedEvents.contains(eventId)

            self.notified = user.notifiedEvents.contains(eventId)
        }
        
        if let end = try container.decodeIfPresent(String.self, forKey: .endDate) {
            self.endDate = end.dateFromPostgresString()
        }
        if let start = try container.decodeIfPresent(String.self, forKey: .startDate) {
            self.startDate = start.dateFromPostgresString()
        }
        
        if self.contributed {
            let count = AMDImprintItem.getAllAssetsCount(event: event!, start: self.startDate, end: self.endDate)

            self.contributedAssetsCount = count
        }
        
        if let imageMetaData = try container.decodeIfPresent(AMDFile.self, forKey: .image) {

            imageMetaData.format = "png"
            imageMetaData.width = Int(UIScreen.main.bounds.width)
            imageMetaData.height = Int(UIScreen.main.bounds.height)

            self.imageMeta = imageMetaData
        }
    }
}
