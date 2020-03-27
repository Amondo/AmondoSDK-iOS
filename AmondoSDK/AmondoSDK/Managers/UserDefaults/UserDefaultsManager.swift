//
//  UserDefaultsManager.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/31/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

struct UserDefaultsManager {

    private static let defaults = UserDefaults.standard

    static var shouldSkipGDPR: Bool? {
        get {
            return defaults.bool(forKey: "skipGDPR")
        }
        set {
            defaults.set(newValue, forKey: "skipGDPR")
        }
    }
    
    static var shouldSkipTutorial: Bool? {
        get {
            return defaults.bool(forKey: "skipTutorial")
        }
        set {
            defaults.set(newValue, forKey: "skipTutorial")
        }
    }
    
    static var didSkipPermissionCamera: Bool? {
        get {
            return defaults.bool(forKey: "skipCamera")
        }
        set {
            defaults.set(newValue, forKey: "skipCamera")
        }
    }
    
    static var didSkipPermissionNotifications: Bool? {
        get {
            return defaults.bool(forKey: "skipNotifications")
        }
        set {
            defaults.set(newValue, forKey: "skipNotifications")
        }
    }
    
    static var didShowPermissionNotifications: Bool? {
        get {
            return defaults.bool(forKey: "showNotificationsPermission")
        }
        set {
            defaults.set(newValue, forKey: "showNotificationsPermission")
        }
    }

}
