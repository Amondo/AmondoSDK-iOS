//
//  AMDAsset+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import AVKit

extension AMDAsset {

    func generateThumnail(_ asset: AVAsset, fromTime: CMTime) -> UIImage? {

        let assetImgGenerate: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.requestedTimeToleranceAfter = CMTime.zero
        assetImgGenerate.requestedTimeToleranceBefore = CMTime.zero

        do {

            let img: CGImage = try assetImgGenerate.copyCGImage(at: fromTime, actualTime: nil)
            let frameImg: UIImage = UIImage(cgImage: img)

            return frameImg
        } catch {

            return nil
        }
    }

}
