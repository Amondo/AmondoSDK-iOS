//
//  ImprintGridVC+UploadManagerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension ImprintGridViewController: UploadManagerDelegate {
    
    func uploadManagerErrorOccured() {
        showUploadError()
    }
    
    func uploadManagerCompleted() {
        showUploadCompleted()
    }
    
    func uploadManagerProgress(progress: Double) {

    }
    
}
