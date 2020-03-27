//
//  ImprintActionsVC+Analytics.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension ImprintActionsViewController {
    
    func logShare (action: String) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintShare, params: ["source": "hamburger" as AnyObject, "action": action as AnyObject, "imprint_id": imprint.event?.id as AnyObject])
    }
}
