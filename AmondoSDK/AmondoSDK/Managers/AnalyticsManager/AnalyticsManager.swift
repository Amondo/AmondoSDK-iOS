//
//  AnalyticsManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/24/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import Alamofire

struct AnalyticsEvent {
    static let userRegister = "USER_REGISTER"
    static let appOpen = "APP_OPEN"
    static let imprintOpen = "IMPRINT_OPEN"
    static let tileOpen = "TILE_OPEN"
    static let imprintShare = "IMPRINT_SHARE"
    static let imprintSubscriber = "IMPRINT_SUBSCRIBE"
    static let imprintContribute = "IMPRINT_CONTRIBUTE"
    static let imprintLike = "IMPRINT_LIKE"
    static let imprintUnLike = "IMPRINT_UNLIKE"
    static let imprintClose = "IMPRINT_CLOSE"
    static let imprintReport = "IMPRINT_REPORT"
    static let categoryOpen = "CATEGORY_OPEN"
}

struct AnalyticsManager {

    static func logEvent(event: String, params: Dictionary<String, AnyObject>) {

        let parameters: Parameters = ["event": event, "data": params, "partner_id": AMDUser.currentUser()?.id as Any, "source": "iOS", "date": Date().stringAnalytics()]

        Alamofire.request(URL(string: "https://analytics.amondo.com/1.0/event")!, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
    }

}
