//
//  AMDFile+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation

extension AMDFile {

    func dataToImage(data: Data!) -> UIImage {
        return UIImage(data: data)!
    }

    func dataToVideo_AVPlayer() -> AVPlayer {
        let ass = AVAsset(url: self.cacheUrl)
        let playerItem = AVPlayerItem(asset: ass)
        let avPlayer = AVPlayer(playerItem: playerItem)
        return avPlayer
    }

    func checkDoesCacheExist() -> Bool {
        if self.corrupted {
            return false
        }

        if self.cacheUrl == nil {
            return false
        }

        //check the cache directory

        do {
            _ = try Data(contentsOf: self.cacheUrl!)
            self.cached = true
        } catch {
            self.cached = false
        }

        return cached
    }

    func dataFromCache() -> Data? {

        if self.corrupted {
            return nil
        }

        if self.cacheUrl == nil {
            return nil
        }

        do {
            let result = try Data(contentsOf: self.cacheUrl!)
            return result
        } catch {
            return nil
        }
    }

    func writeDataToCache(data: Data) -> Bool {

        if self.corrupted {
            return false
        }

        if self.cacheUrl == nil {
            return false
        }

        do {
            try data.write(to: self.cacheUrl, options: [])
            return true
        } catch {
            return false
        }
    }

    func cacheURLConstructor() -> URL {

        if self.corrupted {
            return URL(fileURLWithPath: "")
        }

        var url: URL?
        let tempPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let tempDocumentsDirectory: AnyObject = tempPath[0] as AnyObject

        var uniqueVideoID = self.publicID! + "-" + String(self.version) + "-" + String(self.width) + "." + self.format!
        uniqueVideoID = uniqueVideoID.replacingOccurrences(of: "/", with: "_")

        let tempDataPath = tempDocumentsDirectory.appendingPathComponent(uniqueVideoID) as String

        url = URL(fileURLWithPath: tempDataPath)

        return url!
    }

    func saveDataToCache(data: Data) -> Bool {
        if self.corrupted {
            return false
        }
        return writeDataToCache(data: data)
    }

    func parsedURL() -> String {
        if self.corrupted {
            return ""
        }

        if type == .icon {
            return self.url
        }

        let scale = UIScreen.main.scale
        let width = Int(CGFloat(self.width) * scale)
        let height = Int(CGFloat(self.height) * scale)

        if type == .video {
            return "https://res.cloudinary.com/amondo-media/video/upload/c_limit,h_\(height),q_\(self.quality),w_\(width)/\(publicID!).\(format!)"
        }

        if type == .videoFrame {
            return "https://res.cloudinary.com/amondo-media/video/upload/c_limit,h_\(height),q_\(self.quality),w_\(width)/\(publicID!).png"
        }

        if type == .smallImage {
            return "https://res.cloudinary.com/amondo-media/image/upload/c_limit,h_\(height),q_\(quality),w_\(width)/e_blur:300/\(publicID!).\(format!)"
        }

        return "https://res.cloudinary.com/amondo-media/image/upload/c_limit,h_\(height),q_\(quality),w_\(width)/\(publicID!).\(format!)"
    }

    @discardableResult func getDataInBackground(completion:@escaping (_ error: Error?, _ data: Data?, _ cached: Bool) -> Void) -> DataRequest? {

        if self.corrupted {
            completion(StringError("Problem"), nil, false)
            return nil
        }

        loading = true

        var urlstring = parsedURL()

        if checkDoesCacheExist() {
            if let data = dataFromCache() {
                completion(nil, data, true)
                self.loading = false
                return nil
            }
        }
        let allowedCharacterSet = (CharacterSet(charactersIn: "<>,{} @").inverted)

        if let escapedString = urlstring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            urlstring = escapedString
        } else {
            urlstring = ""
            return nil
        }

        self.cached = false
        //print("Get data in background from: \(urlstring)")

        let req = Alamofire.request(URL(string: urlstring)!, method: .get).responseData(completionHandler: { (response: DataResponse<Data>) in
            switch response.result {

            case.success(let data):
                if !self.cached {
                    self.cached = self.saveDataToCache(data: data)
                }
                DispatchQueue.main.async {
                    completion(nil, data, false)
                    self.loading = false
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    completion(error, nil, false)
                    self.loading = false
                }
            }
        }).downloadProgress { progress in
            //print(progress.fractionCompleted)
        }

        return req
    }
}
