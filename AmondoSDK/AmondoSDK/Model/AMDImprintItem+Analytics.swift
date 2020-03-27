//
//  AMDImprintItem+Analytics.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

extension AMDImprintItem {

    func logImprintOpen(event: AMDEvent) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintOpen, params: ["imprint_id": event.id as AnyObject, "user_ids": AMDUser.currentUser()?.id! as Any as AnyObject])
    }
}
