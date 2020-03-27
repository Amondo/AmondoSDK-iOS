//
//  EventCollectionViewCell+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension EventCollectionViewCell {
    
    @IBAction func actionLikeUnlike() {
        item.liked = !item.liked
        buttonAction.isSelected = item.liked
        if item.liked {
            UIImpactFeedbackGenerator().impactOccurred()
            logLike(event: item.event!)
            AMDUser.currentUser()?.addUniqueEvent(id: item.objectID())
            AMDUser.currentUser()?.addUniqueObject(object: item.objectID(), forKey: "savedEvents")
            AMDUser.currentUser()?.addUniqueObject(object: item.objectID(), forKey: "allEvents")
            UserAPIManager.saveNewEvent(event: item.objectID()) { (error: AmondoError?, success: Bool) in
                UserAPIManager.updateRemoteAttributesForUser(user: AMDUser.currentUser()!, attributes: ["allEvents": AMDUser.currentUser()!.allEvents!, "savedEvents": AMDUser.currentUser()!.savedEvents]) { (_: AmondoError?, _: Bool, _: AMDUser?) in
                    NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
                }
            }
        } else {
            logUnlike(event: item.event!)
            AMDUser.currentUser()!.removeObject(object: item.objectID(), forKey: "allEvents")
            AMDUser.currentUser()!.removeObject(object: item.objectID(), forKey: "savedEvents")
            AMDUser.currentUser()!.removeEvent(id: item.objectID())
            UserAPIManager.deleteEvent(event: item.objectID()) { (error:AmondoError?, success:Bool) in
                UserAPIManager.updateRemoteAttributesForUser(user: AMDUser.currentUser()!, attributes: ["allEvents": AMDUser.currentUser()!.allEvents!, "savedEvents": AMDUser.currentUser()!.savedEvents]) { (_: AmondoError?, _: Bool, _: AMDUser?) in
                    NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
                }
            }
        }
    }
}
