//
//  ImprintVC+SelectMediaViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/14/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintViewController: SelectMediaViewControllerDelegate {
    
    func uploadStart(assets: Array<AMDAsset>) {
        self.viewUploadWrapper.isHidden = false
        uploadOpen = true
        UploadManager.instance.upload(assets: assets, imprint: currentImprint)
        UploadManager.instance.delegate = self
        pageControlAssets.isHidden = true
        hideActionButtons()

        layoutConstraintImprintWrapperBottom.constant = -(UIScreen.main.bounds.size.height-150)
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
            self.animateUpload()
        })
    }
    
}
