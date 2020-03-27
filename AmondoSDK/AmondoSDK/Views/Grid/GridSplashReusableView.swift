//
//  GridSplashReusableView.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class GridSplashReusableView: UICollectionReusableView {
    
    @IBOutlet weak var viewActionBlurView: UIView!
    @IBOutlet weak var buttonAction: UIButton!
    
    var imprint: AMDImprintItem!
    
    func prepareGfx() {
        viewActionBlurView.layer.cornerRadius = 18
        viewActionBlurView.layer.masksToBounds = true
        
        buttonAction.isUserInteractionEnabled = true
        buttonAction.isSelected = AMDUser.currentUser()!.events_users.contains(imprint.objectID())
        buttonAction.setImage(UIImage(named:"favourite-selected"), for: .selected)
        buttonAction.setImage(UIImage(named:"favourite"), for: .normal)
        buttonAction.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    @IBAction func actionLikeUnlike() {
        imprint.liked = !imprint.liked
        buttonAction.isSelected = imprint.liked
        if imprint.liked {
            UIImpactFeedbackGenerator().impactOccurred()
            logLike(event: imprint.event!)
            AMDUser.currentUser()?.addUniqueEvent(id: imprint.objectID())
            AMDUser.currentUser()?.addUniqueObject(object: imprint.objectID(), forKey: "savedEvents")
            AMDUser.currentUser()?.addUniqueObject(object: imprint.objectID(), forKey: "allEvents")
            UserAPIManager.saveNewEvent(event: imprint.objectID()) { (error: AmondoError?, success: Bool) in
                UserAPIManager.updateRemoteAttributesForUser(user: AMDUser.currentUser()!, attributes: ["allEvents": AMDUser.currentUser()!.allEvents!, "savedEvents": AMDUser.currentUser()!.savedEvents]) { (_: AmondoError?, _: Bool, _: AMDUser?) in
                    NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
                    NotificationCenter.default.post(name: Notification.Name("SECTION_REFRESH"), object: self.imprint)
                }
            }
        } else {
            logUnlike(event: imprint.event!)
            AMDUser.currentUser()!.removeObject(object: imprint.objectID(), forKey: "allEvents")
            AMDUser.currentUser()!.removeObject(object: imprint.objectID(), forKey: "savedEvents")
            AMDUser.currentUser()!.removeEvent(id: imprint.objectID())
            UserAPIManager.deleteEvent(event: imprint.objectID()) { (error:AmondoError?, success:Bool) in
                UserAPIManager.updateRemoteAttributesForUser(user: AMDUser.currentUser()!, attributes: ["allEvents": AMDUser.currentUser()!.allEvents!, "savedEvents": AMDUser.currentUser()!.savedEvents]) { (_: AmondoError?, _: Bool, _: AMDUser?) in
                    NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
                    NotificationCenter.default.post(name: Notification.Name("SECTION_REFRESH"), object: self.imprint)
                }
            }
        }
    }
    
    func logLike(event: AMDEvent) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintLike, params: ["imprint_id": event.id as AnyObject])
    }
    
    func logUnlike(event: AMDEvent) {
        AnalyticsManager.logEvent(event: AnalyticsEvent.imprintLike, params: ["imprint_id": event.id as AnyObject])
    }

}
