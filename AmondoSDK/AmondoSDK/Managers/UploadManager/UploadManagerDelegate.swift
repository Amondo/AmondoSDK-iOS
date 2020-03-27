//
//  UploadManagerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/14/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

protocol UploadManagerDelegate: NSObjectProtocol {
    
    func uploadManagerErrorOccured()
    func uploadManagerCompleted()
    func uploadManagerProgress(progress: Double)
}

