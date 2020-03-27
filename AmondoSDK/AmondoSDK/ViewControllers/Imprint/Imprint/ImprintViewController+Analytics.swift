//
//  ImprintViewController+Analytics.swift
//  Amondo
//
//  Created by developer@amondo.com on 9/6/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

import Foundation

extension ImprintViewController {
    
    func logReport() {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintReport, params: ["imprint_id": currentImprint.event?.id as AnyObject])
    }
    
    func logOpen() {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintOpen, params: ["imprint_id": currentImprint.event?.id as AnyObject])
    }
    
    func logOpen(progress: Float) {
        var shareProgress: Float = 0
        
        if (progress > 0 && progress < 0.25){
            shareProgress = 0.25
        } else if (progress > 0.25 && progress < 0.5) {
            shareProgress = 0.5
        } else if (progress > 0.5 && progress < 0.7) {
            shareProgress = 0.7
        } else if (progress == 1) {
            shareProgress = 1.0
        }
        
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintOpen, params: ["progress" : shareProgress as AnyObject, "imprint_id": currentImprint.event?.id as AnyObject])
    }
    
    func logTileOpen(asset: AMDAsset) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.tileOpen, params: ["tile_id": asset.objectId() as AnyObject, "type": asset.type! as AnyObject, "imprint_id": currentImprint.event?.id as AnyObject])
    }
    
}
