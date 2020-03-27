//
//  ImprintGridVC+SelectMediaViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintGridViewController: SelectMediaViewControllerDelegate {
    
    func uploadStart(assets: Array<AMDAsset>) {
        self.viewUploadWrapper.isHidden = false
        UploadManager.instance.upload(assets: assets, imprint: imprint)
        UploadManager.instance.delegate = self
        hideActionButtons()
        
        layoutConstraintImprintWrapperBottom.constant = -(UIScreen.main.bounds.size.height)
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
            self.animateUpload()
        })
    }
    
}
