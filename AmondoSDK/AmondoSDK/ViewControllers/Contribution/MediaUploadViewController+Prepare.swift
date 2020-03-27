//
//  MediaUploadViewController+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension MediaUploadViewController {
    
    func prepareGfx() {
        labelUploaded.font = Fonts.condensedBoldWithSize(size: 36)
        labelReviewing.font = Fonts.sfSemiBold(size: 15)
        labelReviewingInfo.font = Fonts.sfRegular(size: 14)
        buttonShare.titleLabel?.font = Fonts.sfRegular(size: 16)
        buttonBack.titleLabel?.font = Fonts.sfRegular(size: 16)
    }

    func prepareData() {
        let firstAsset = selectedMedia.first
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true

        manager.requestImage(for: (firstAsset?.asset!)!, targetSize: CGSize(width: 440, height: 680), contentMode: .aspectFit, options: option, resultHandler: {result, _ -> Void in
            self.imageViewHero.image = result!
        })
        uploadData()
    }

}
