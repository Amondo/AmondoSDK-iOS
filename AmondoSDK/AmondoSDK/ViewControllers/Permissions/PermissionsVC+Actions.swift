//
//  PermissionsVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/8/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension PermissionsViewController {
    
    @IBAction func actionClose() {
        layoutConstraintActionsBottom.constant = -350
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.visualEffectViewBlur.alpha = 0
        }
        perform(#selector(delegateClose), with: nil, afterDelay: 0.3)
    }
    
    @objc
    func delegateClose() {
        delegate?.permissionsClosed()
    }
    
    @IBAction func actionNope() {
        var attributes = ["cameraroll_permitted": false]
        if type == PermissionType.camera {
            UserDefaultsManager.didSkipPermissionCamera = true
        } else if type == PermissionType.notifications {
            UserDefaultsManager.didSkipPermissionNotifications = true
            attributes = ["notifications_permitted": false]
        }
        updateUserAttributes(attributes: attributes)
        actionClose()
    }
    
    @IBAction func actionSure() {
        if type == PermissionType.camera {
            if UserDefaultsManager.didSkipPermissionCamera == true {
                UserDefaultsManager.didSkipPermissionCamera = false
            }
            let status = PHPhotoLibrary.authorizationStatus()
            if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { status in
                    switch status {
                    case .authorized:
                        let attributes = ["cameraroll_permitted": true]
                        self.updateUserAttributes(attributes: attributes)
                        self.delegate?.permissionsApproved()
                    case .denied, .restricted:
                        let attributes = ["cameraroll_permitted": false]
                        self.updateUserAttributes(attributes: attributes)
                        self.actionClose()
                    default:
                        return
                    }
                }
            } else if status == .denied || status == .restricted {
                if let url = URL(string:UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: { success in
                        })
                    }
                }
                actionClose()
            } else {
                //system is approved, but user is false
                let attributes = ["cameraroll_permitted": true]
                self.updateUserAttributes(attributes: attributes)
                self.delegate?.permissionsApproved()
            }
        } else if type == PermissionType.notifications {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            if !isRegisteredForRemoteNotifications {
                if UserDefaultsManager.didShowPermissionNotifications ?? false {
                    if let url = URL(string:UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: { success in
                            })
                        }
                        actionClose()
                    }
                } else {
                    UserDefaultsManager.didShowPermissionNotifications = true
                    UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
                    UIApplication.shared.registerForRemoteNotifications()
                    let attributes = ["notifications_permitted": true]
                    updateUserAttributes(attributes: attributes)
                    actionClose()
                }
            } else {
                //system is approved, but user is false
                let attributes = ["notifications_permitted": true]
                updateUserAttributes(attributes: attributes)
                actionClose()
            }
        }
    }
    
    func updateUserAttributes(attributes: [String: Any]) {
        UserAPIManager.updateRemoteAttributesForUser(user:AMDUser.currentUser()!, attributes: attributes, completion: { (error, success, attributes) in
            if success {
                UserAPIManager.remoteAttributesForUser(user: AMDUser.currentUser()!, completion: { (error, success, attributes) in
                })
            } else {
                
            }
        })
    }
}
