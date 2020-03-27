//
//  PermissionsVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/8/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import PhotosUI

extension PermissionsViewController {
    
    func prepareBlur() {
        UIView.animate(withDuration: 1.0) {
            self.visualEffectViewBlur.alpha = 1
        }
    }
    
    func prepareGfx() {
        viewBackground.layer.cornerRadius = 20
        viewBackground.layer.masksToBounds = true
        
        buttonSettings.isHidden = true
        buttonNope.isHidden = true
        buttonSure.isHidden = true
        buttonClose.isHidden = true
        
        if type == PermissionType.camera {
            if UserDefaultsManager.didSkipPermissionCamera ?? false {
                buttonSettings.isHidden = false
                layoutConstraintHeadingBottom.constant = 110
            } else {
                if noMedia {
                    buttonClose.isHidden = false
                } else {
                    buttonNope.isHidden = false
                    buttonSure.isHidden = false
                }
            }
        } else if type == PermissionType.notifications {
            if UserDefaultsManager.didSkipPermissionNotifications ?? false {
                buttonSettings.isHidden = false
                layoutConstraintHeadingBottom.constant = 110
            } else {
                buttonNope.isHidden = false
                buttonSure.isHidden = false
            }
        }
        
        labelHeading.font = Fonts.sfBold(size: 22)
        labelDescription.font = Fonts.sfRegular(size: 16)
        for button in [buttonClose, buttonSure, buttonNope, buttonClose, buttonSettings] {
            button?.titleLabel?.font = Fonts.sfSemiBold(size: 15)
            button?.layer.cornerRadius = 8
            button?.layer.masksToBounds = true
        }
        
        buttonNope.layer.borderColor = Colors.white.cgColor
        buttonNope.layer.borderWidth = 1
        
        view.layoutIfNeeded()
    }
    
    func prepareData() {
        if type == PermissionType.camera {
            labelHeading.text = noMedia ? "🤳  Contribute" : "🤳  Access to Camera Roll"
            if UserDefaultsManager.didSkipPermissionCamera ?? false {
                labelDescription.attributedText = prepareDescriptionString(text: "Changed your mind?")
                if PHPhotoLibrary.authorizationStatus() == .notDetermined {
                    buttonSettings.setTitle("Enable Access to Camera", for: .normal)
                } else {
                    buttonSettings.setTitle("Open Settings to Change", for: .normal)
                }
                self.viewNotification = NotificationService.showNotification(view: self.labelHeading, text: "You can’t submit content unless you’ve enabled Camera Roll access.", emoji: "😬", backgroundColor: UIColor.Notification.negative, textColor: UIColor.Notification.negativeText, paddingConstant: 20.0, padding: .bottom)
                self.viewNotification?.dismissable = false
            } else {
                labelDescription.attributedText = noMedia ? prepareDescriptionString(text: "You don’t have any photos or videos that match the dates of this event.") : prepareDescriptionString(text: "In order to submit your content to the Imprint you need the provide access to your Camera Roll. That cool?")
            }
        } else if type == PermissionType.notifications {
            labelHeading.text = "🔔 Push Notifications"
            if UserDefaultsManager.didSkipPermissionNotifications ?? false {
                labelDescription.attributedText = prepareDescriptionString(text: "Changed your mind?")
                if UserDefaultsManager.didShowPermissionNotifications ?? false {
                    buttonSettings.setTitle("Open Settings to Change", for: .normal)
                } else {
                    buttonSettings.setTitle("Enable Push Notifications", for: .normal)
                }
                self.viewNotification = NotificationService.showNotification(view: self.labelHeading, text: "We can’t let you know an Imprint is live unless you enable notifications.", emoji: "🙊", backgroundColor: UIColor.Notification.negative, textColor: UIColor.Notification.negativeText, paddingConstant: 20.0, padding: .bottom)
                self.viewNotification?.dismissable = false
            } else {
                labelDescription.attributedText = prepareDescriptionString(text: "For us to let you know a new Imprint is live, you’ll need to enable push notifications. That cool?")
            }
        }
    }
    
    func prepareDescriptionString(text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4.5
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
}
