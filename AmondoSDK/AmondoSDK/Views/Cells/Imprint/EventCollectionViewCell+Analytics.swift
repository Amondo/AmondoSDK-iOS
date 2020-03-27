//
//  EventCollectionViewCell+Analytics.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension EventCollectionViewCell {
    func logLike(event: AMDEvent) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintLike, params: ["imprint_id": event.id as AnyObject])
    }
    
    func logUnlike(event: AMDEvent) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintLike, params: ["imprint_id": event.id as AnyObject])
    }
}
