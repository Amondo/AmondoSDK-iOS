//
//  SettingsItem+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/7/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

extension SettingsItem {
    
    static func items() -> Dictionary<String, [SettingsItem]> {
        var settingsDict = Dictionary<String, [SettingsItem]>()
        
        let sectionOne = "Account Settings"
        let fullName = (AMDUser.currentUser()?.firstName!)! + " " + (AMDUser.currentUser()?.lastName!)!
        let name = SettingsItem(title: "Name", type: .accessory, value: fullName)
        let email = SettingsItem(title: "Email", type: .accessory, value: (AMDUser.currentUser()?.email)!)
        let changePassword = SettingsItem(title: "Change Password", type: .accessory, value: "")
        settingsDict[sectionOne] = [name, email, changePassword]
        
        let sectionTwo = "Privacy and Notifications"
        let notifications = SettingsItem(title: "Notifications", type: .switcher, value: "")
        let cameraRoll = SettingsItem(title: "Camera Roll Access", type: .switcher, value: "")
        settingsDict[sectionTwo] = [notifications, cameraRoll]
        
        let sectionThree = "Help and Social"
        let helpFeedback = SettingsItem(title: "Help & Feedback", type: .accessory, value: "")
        let likeFacebook = SettingsItem(title: "Like us on Facebook", type: .accessory, value: "")
        let followTwitter = SettingsItem(title: "Follow us on Twitter", type: .accessory, value: "")
        let followInstagram = SettingsItem(title: "Follow us on Instagram", type: .accessory, value: "")
        let rateUs = SettingsItem(title: "Rate us on App Store", type: .accessory, value: "")
        settingsDict[sectionThree] = [helpFeedback, likeFacebook, followTwitter, followInstagram, rateUs]
        
        let sectionFour = "Legal"
        let terms = SettingsItem(title: "Terms of Use", type: .accessory, value: "")
        let privacy = SettingsItem(title: "Privacy Policy", type: .accessory, value: "")
        settingsDict[sectionFour] = [terms, privacy]
        
        let sectionFive = "Account"
        let logOut = SettingsItem(title: "Log Out", type: .simple, value: "")
        let delete = SettingsItem(title: "Delete Account", type: .accessory, value: "")
        settingsDict[sectionFive] = [logOut, delete]
        
        return settingsDict
    }
    
}
