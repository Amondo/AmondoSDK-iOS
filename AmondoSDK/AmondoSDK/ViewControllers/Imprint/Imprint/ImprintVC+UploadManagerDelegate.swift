//
//  ImprintVC+UploadManagerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/14/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

extension ImprintViewController: UploadManagerDelegate {
    
    func uploadManagerErrorOccured() {
        showUploadError()
    }
    
    func uploadManagerCompleted() {
        showUploadCompleted()
    }
    
    func uploadManagerProgress(progress: Double) {
        print("uploding..")
        print(progress)
    }
    
}
