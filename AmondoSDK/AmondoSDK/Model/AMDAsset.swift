//
//  Asset.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import Photos
import CoreLocation
import UIKit

class AMDAsset: NSObject {
    
    enum Orientation: String {
        case portrait
        case square
        case landscape
        case none
    }

    var type: String!
    var asset: PHAsset?
    var location: CLLocation?
    var coverImage: UIImage?
    var loading = false
    var cacheState = "small"
    var orientationLabel = "s"
    var orientation: Orientation?
    var album: AMDSpotify?
    var instagram: AMDInstagram?
    var article: AMDArticle?
    var video: AMDVideo?
    var avPlayerItem: AVPlayerItem?
    var avPlayer: AVPlayer?
    var dataURL: URL?
    var tileFrame: CGRect!
    var date: Date!
    var isTwitterStatus: Bool! = false
    var statusType: Bool! = false
    var offsetY: CGFloat!

    init(type: String) {
        self.type = type
        self.isTwitterStatus = false
    }

    var aobject: [String: Any]? {
        didSet {
            if aobject != nil {

                self.type = aobject!["type"] as! String

                if self.type == "instagram" {

                } else if self.type == "spotify" {

                } else if self.type == ""{

                }
            }
        }
    }

    func objectId() -> String {
        if let assetObject = self.aobject {
            return assetObject["id"] as! String
        }
        return (self.asset?.localIdentifier)!
    }

    class func retrieveAssetsForEvent(_ event: String, completion:@escaping (_ error: Error?, _ assets: [AMDAsset]) -> Void) {
        
        Network.shared.apollo!.fetch(query: GetTilesQuery(imprintId: event )) {
            result in
            
            switch result  {
            case .success(let graphQLResult):
                let objects = graphQLResult.data?.tiles
                var assets = [AMDAsset]()

                for objectGraphQL in objects! {
                    var object: Dictionary = Dictionary<String, Any?>()
                    object.values = objectGraphQL.resultMap.values
                    let rawType = object["type"] as? TileType
                    object["type"] = rawType?.rawValue
                    let rawSource = object["source"] as? TileSource
                    object["source"] = rawSource?.rawValue
                    
                    let type = rawType?.rawValue as! String
                    
                    let asset = AMDAsset(type: type)
                    asset.statusType = false
                    asset.aobject = object
                    
                    if let objectDate = (object["date"] as? String) {
                        asset.date = objectDate.dateFromPostgresString()
                    } else {
                        asset.date = Date.distantPast
                    }
                    
                    if let point = object["geoPoint"] as? [Double] {
                        asset.location = CLLocation(latitude: point[0], longitude: point[1])
                    }

                    if type == "photo" || type == "status" {
                        let post = AMDInstagram()
                        post.description = object["description"] as? String
                        post.location = object["location"] as? String
                        post.username = object["username"] as? String
                        if let likes = object["likes"] as? Int {
                            post.likes = likes
                        } else {
                            post.likes = 0
                        }
                        post.geopoint = object["geopoint"] as? [Double]
                        post.source = object["source"] as? String
                        asset.instagram = post
                    }

                    if type == "video" {
                        let post = AMDVideo()
                        post.description = object["description"] as? String
                        post.location = object["location"] as? String
                        post.username = object["username"] as? String
                        if let likes = object["likes"] as? Int {
                            post.likes = likes
                        } else {
                            post.likes = 0
                        }
                        post.geopoint = object["geopoint"] as? [Double]
                        post.source = object["source"] as? String
                        asset.video = post

                    }

                    if type == "article" {
                        let article = AMDArticle()
                        article.url = (object["url"] as? String)
                        article.description = (object["description"] as? String)
                        article.publisher = (object["source"] as? String)
                        article.author = (object["username"] as? String)
                        asset.article = article
                    }
                    assets.append(asset)
                }

                DispatchQueue.main.async {
                    completion(nil, assets)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(error, [])
                }
            }
        }

//        let aquery = AMDQuery(className: "DataAssets")
//        aquery.whereKey(key: "event_id", isEqualTo: event)
//
//        aquery.orderByAscending(key: "date")
//        aquery.whereKeyExists(key: "file")
//        aquery.limit = 500
//        aquery.getObjectsInBackground { (error: Error?, objects: [Dictionary<String, Any>]?) in
//
//        }
    }
}
