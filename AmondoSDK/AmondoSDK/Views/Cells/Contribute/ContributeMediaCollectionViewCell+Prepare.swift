//
//  ContributeMediaCollectionViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/26/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension ContributeMediaCollectionViewCell {

    func prepareCell() {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = false
        manager.requestImage(for: asset.asset!, targetSize: CGSize(width: 200, height: 300), contentMode: .aspectFit, options: option, resultHandler: {result, _ -> Void in
            self.imageViewThumb.image = result!
        })
        let duration = asset.asset?.duration ?? 0
        labelVideoDuration.text = duration > 0 ? stringFromTimeInterval(interval: duration) : ""
        imageViewSelected.isHidden = !isMediaSelected
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }

}
