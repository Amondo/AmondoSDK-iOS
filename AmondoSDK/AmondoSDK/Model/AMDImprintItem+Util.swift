//
//  AMDImprintItem+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVFoundation

extension AMDImprintItem {

    func loadItemsForEvent(fromVC: UIViewController, completionDone: @escaping () -> Void) {

        self.items.removeAll()

        curatedAssets = [AMDAsset]()

        self.loading = true

        self.loadingPercent = 20

        let eventID: String? = self.event?.id

        for request in self.dataRequests {
            request?.cancel()
        }
        self.dataRequests.removeAll()

        AMDAsset.retrieveAssetsForEvent(eventID!) { error, assets in
            if error == nil {
                self.items = assets.filter {
                    let type = $0.aobject?["type"] as! String
                    return type == "video" || type == "photo" || type == "url" || type == "status" || type == "article" || type == "image"
                }
                var downloaded = 0

                self.loadingPercent = 20

                for ev in assets {
                    ev.cacheState = "small"
                    var file = AMDFile(file: ev.aobject!["file"] as! [String: Any], ftype: "photo")
                    file.width = 4
                    file.height = 4
                    if  ev.aobject!["type"] as! String == "video" {
                        file.type = AMDFileType.video
                        file = AMDFile(file: ev.aobject!["file"] as! [String: Any], ftype: "videoFrame")
                        file.width = 10
                        file.height = 10
                        file.format = "png"
                        file.cacheUrl = file.cacheURLConstructor()
                        file.cached = file.checkDoesCacheExist()
                    }

                    let call = file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
                        if error == nil {

                            // caching images
                            if  ev.aobject!["type"] as! String == "photo" {
                                let result = UIImage(data: data!)
                                ev.coverImage = result
                            }

                            if  ev.aobject!["type"] as! String == "article" {
                                let result = UIImage(data: data!)
                                ev.coverImage = result
                            }

                            if  ev.aobject!["type"] as! String == "video" {
                                let result = UIImage(data: data!)
                                ev.coverImage = result
                            }

                            downloaded += 1
                            self.loadingPercent = 20 + 80 * (Float(downloaded) / Float(assets.count))

                            if downloaded == assets.count {
                                // Downloaded
                                self.loading = false
                                self.loaded = true
                                completionDone()
                                return
                            }

                        } else {

                            downloaded += 1
                            ev.type = "error"

                            if downloaded == assets.count {

                                // Downloaded
                                self.loading = false
                                self.loaded = true
                                completionDone()

                                return
                            }
                        }
                    })

                    self.dataRequests.append(call)

                }
            }
        }
    }

    class func getAllAssetsCount(event: AMDEvent, start: Date, end: Date) -> Int {

        guard let user = AMDUser.currentUser(),
            !user.photosPermitted,
            PHPhotoLibrary.authorizationStatus() != .denied else {
                return 0
        }

        var locationRadius: Double = 250

        if let filterRadius = event.locationRadius {
            locationRadius = filterRadius
        }

        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", start as CVarArg, end as CVarArg)

        let result = PHAsset.fetchAssets(with: options)

        var count = 0

        result.enumerateObjects({ object, _, _ in

            let asset = object

            if let assetCoordinate = asset.location {

                let eventCoordinate = CLLocation(from: event.geoPoint)

                let distanceInMeters = assetCoordinate.distance(from: eventCoordinate)

                if distanceInMeters < locationRadius {
                    count += 1
                }

            }

        })

        return count
    }

    //TO DO: Remove!!! normal realisation placed above with AMDEvent
    class func getAllAssetsCount(start: Date, end: Date, event: [String: Any]) -> Int {

        if AMDUser.currentUser()!.photosPermitted == false {

            return 0
        }

        var geoPoint = event["geoPoint"] as! [Double]

        var locationRadius: Double = 250
        if let filterRadius = event["locationRadius"] as? Double {
            locationRadius = filterRadius
        }

        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", start as CVarArg, end as CVarArg)

        let result = PHAsset.fetchAssets(with: options)

        var count = 0

        result.enumerateObjects({ object, _, _ in

            let asset = object

            if asset.location != nil {

                let assetCoordinate = asset.location!
                let eventCoordinate = CLLocation(latitude: geoPoint[0], longitude: geoPoint[1])

                let distanceInMeters = assetCoordinate.distance(from: eventCoordinate)

                if distanceInMeters < locationRadius {

                    count += 1
                }

            }

        })

        return count

    }

    func populateSectionsForImprintNew() -> [AMDAsset] {
        if AMDUser.currentUser()!.photosPermitted == false {
            return []
        }

        var assets = [AMDAsset]()
        var deviceAssets = [(AMDAsset, Bool, Bool)]()

        let ignoreAssets = getIgnoreAssets(self.event!.id)

        let startDate = event?.date ?? Date.init()
        let endDateTomorrow = Calendar.current.date(byAdding: .day, value: 2, to: startDate)
        let endDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: endDateTomorrow ?? Date.init())!

        let options = PHFetchOptions()

        options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", startDate as CVarArg, endDate as CVarArg)

        let result = PHAsset.fetchAssets(with: options)

        result.enumerateObjects({ object, _, _ in
            let asset = object
            var id = "devicePhoto"
            if asset.mediaType == .image {
                id = "devicePhoto"
            } else if asset.mediaType == .video {
                id = "deviceVideo"
            }

            let amdasset = AMDAsset(type: id)
            amdasset.asset = asset
            amdasset.location = asset.location
            amdasset.date = asset.creationDate!

            if asset.pixelWidth > asset.pixelHeight {
                amdasset.orientationLabel = "l"
            } else if asset.pixelWidth < asset.pixelHeight {
                amdasset.orientationLabel = "p"
            }
            
            assets.append(amdasset)
            deviceAssets.append((amdasset, true, true))
        })

        return assets.reversed()
    }

    func populateSectionsForImprint() -> [(AMDAsset, Bool, Bool)] {
        if AMDUser.currentUser()!.photosPermitted == false {
            return []
        }
        var assets = [AMDAsset]()
        let deviceAssets = [(AMDAsset, Bool, Bool)]()

        let ignoreAssets = getIgnoreAssets(self.event!.id)

        let startDate = self.startDate
        var endDate: Date? = self.endDate

        if endDate == .none {
            endDate = startDate.addingTimeInterval(60 * 60 * 10)
        }

        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        options.predicate = NSPredicate(format: "creationDate > %@ && creationDate < %@", startDate as CVarArg, endDate! as CVarArg)

        let result = PHAsset.fetchAssets(with: options)

        result.enumerateObjects({ object, _, _ in

            let asset = object

            var id = "devicePhoto"
            if asset.mediaType == .image {
                id = "devicePhoto"
            } else if asset.mediaType == .video {
                id = "deviceVideo"
            }

            let amdasset = AMDAsset(type: id)
            amdasset.asset = asset
            amdasset.location = asset.location
            amdasset.date = asset.creationDate!

            if asset.pixelWidth > asset.pixelHeight {
                amdasset.orientationLabel="l"
            } else if asset.pixelWidth < asset.pixelHeight {
                amdasset.orientationLabel="p"
            }

            let ran = Int(arc4random_uniform(UInt32(assets.count)))

            if !ignoreAssets.contains(amdasset.asset!.localIdentifier) {
                assets.insert(amdasset, at: ran)
            }
        })

        return deviceAssets
    }

    func parseURL(_ file: String) -> URL? {
        let parseFilesCache = "Parse/PFFileCache"
        let fileManager = FileManager.default
        let cacheDirectoryURL = fileManager.urls(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask)
        let PFFileCacheDirectoryURL = cacheDirectoryURL[0].appendingPathComponent(parseFilesCache, isDirectory: true)
        let filet = PFFileCacheDirectoryURL.appendingPathComponent(file)
        return filet
    }

    func addImprintToMenu(_ imprint: AMDImprintItem, collectionView: UICollectionView?, indexPath: IndexPath?, animated: Bool, completionDone: @escaping () -> Void) {

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        
        imprint.items.removeAll()
        //TEST
        IMPRINTVC = nil
        curatedAssets = imprint.items
        IMPRINTVC?.view.removeFromSuperview()
        IMPRINTVC = nil

        let imprintStoryboard: UIStoryboard = UIStoryboard(name: "Imprint", bundle: nil)
        IMPRINTVCNAV = imprintStoryboard.instantiateInitialViewController() as? UINavigationController
        IMPRINTVC = IMPRINTVCNAV?.viewControllers.first as? ImprintGridViewController

        IMPRINTVC!.imprint = imprint

        if !animated {
            self.owner.view.animateOpacity(alpha: 0, duration: 0.3)
            self.owner.present(IMPRINTVCNAV!, animated: true) {
                completionDone()
            }
            return
        }

        if indexPath != nil {

            collectionView?.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: false)
            
            self.owner.present(IMPRINTVCNAV!, animated: false) {
                self.owner.view.alpha = 0
                completionDone()
            }
        }

        return

    }

    func cancelLoadingImprints() {
        for request in self.dataRequests {
            request?.cancel()
        }
        self.dataRequests.removeAll()
        self.items.removeAll()
    }

    func closeImprint(completionDone: @escaping () -> Void) {

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }


        cancelLoadingImprints()

        IMPRINTVC!.dismiss(animated: true, completion: .none)

        return
            UIView.animate(withDuration: 0.3, animations: {
                IMPRINTVC!.view.alpha = 0
                IMPRINTVC!.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                IMPRINTVC!.view.center.x = UIScreen.main.bounds.width / 2
            }) { _ in

                //IMPRINTVC?.invalidateImprintLayout()

                IMPRINTVC!.navigationController?.dismiss(animated: false, completion: {
                    self.owner.view.alpha = 0
                    IMPRINTVC = nil

                    UIView.animate(withDuration: 0.3, animations: {
                        self.owner.view.alpha = 1
                    }, completion: { _ in
                        IMPRINTVC = nil
                        completionDone()
                    })
                })
        }

    }

}
