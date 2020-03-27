//
//  AMDUser+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import KeychainSwift

extension AMDUser {

    class func setProfileImageData(data: Data) -> Bool {

        if let user = AMDUser.currentUser() {
            let defaults = UserDefaults.standard
            defaults.set(data, forKey: "UserProfileImage-\(user.username!)")
            return true
        }
        return false
    }

    class func currentUser() -> AMDUser? {
        let u = AMDDefaults.Standard.getString(key: "username")
        let t = AMDDefaults.Standard.getString(key: "token")

        if u != nil && t != nil {

            let user = AMDUser(username: u!, password: "")
            user.token = t!

            let ua = user.localUserAtrributes()
            user.email = ua["email"] as? String ?? ""
            user.firstName = ua["firstName"] as? String

            return user
        }
        return nil
    }

    func getContributedSearchDate() -> Date? {
        return .none
    }

    func setContributedSearchDate(date: Date) {
        AMDDefaults.Standard.setDate(key: self.username!+"_ContributedEventsDate", value: date)
    }

    func saveAsCurrentUser(withAttributes: [String: Any]) {
        AMDDefaults.Standard.setString(key: "username", value: username!)
        AMDDefaults.Standard.setString(key: "token", value: token!)
        AMDDefaults.Standard.setData(key: self.username!+"-userAttributes", value: jsonToData(json: withAttributes)!)
    }

    class func logOut() {
        AMDDefaults.Standard.delete(key: "username")
        AMDDefaults.Standard.delete(key: "token")
        UserDefaultsManager.shouldSkipGDPR = false
    }

    func addUniqueObject(object: String, forKey: String) {
        var ua = localUserAtrributes()

        if (ua[forKey] as? [String]) == nil {
            ua[forKey] = [object]
        } else {
            var array = ua[forKey] as! [String]
            if !array.contains(object) {
                array.append(object)
            }
            ua[forKey] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func removeObject(object: String, forKey: String) {
        var ua = localUserAtrributes()

        if (ua[forKey] as? [String]) == nil {
            ua[forKey] = [String]()
        } else {
            var array = ua[forKey] as! [String]
            array = array.filter { $0 != object }
            ua[forKey] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func addUniqueEventContributed(id: String) {
        var ua = localUserAtrributes()

        if (ua["events_users_contributed"] as? [[String: Any]]) == nil {
            ua["events_users_contributed"] = [["event_id": Int(id)!, "user_id": Int(self.id!)!]] as! [[String: Any]]
        } else {
            let object: [String: Any] = ["event_id": Int(id)!, "user_id": Int(self.id!)!]
            var array = ua["events_users_contributed"] as! [[String: Any]]
            var contains = false
            for el in array {
                if el["event_id"] as! Int == Int(id)! {
                    contains = true
                }
            }
            if !contains {
                array.append(object)
            }
            ua["events_users_contributed"] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func removeEventContributed(id: String) {
        var ua = localUserAtrributes()

        if (ua["events_users_contributed"] as? [[String: Any]]) == nil {
            ua["events_users_contributed"] = [[String: Any]]()
        } else {
            var array = ua["events_users_contributed"] as! [[String: Any]]
            array = array.filter { ($0["event_id"] as! Int) != Int(id)! }
            ua["events_users_contributed"] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func addUniqueEventNotified(id: String) {
        var ua = localUserAtrributes()

        if (ua["events_users_notified"] as? [[String: Any]]) == nil {
            ua["events_users_notified"] = [["event_id": Int(id)!, "user_id": Int(self.id!)!]] as [[String: Any]]
        } else {
            let object: [String: Any] = ["event_id": Int(id)!, "user_id": Int(self.id!)!]
            var array = ua["events_users_notified"] as! [[String: Any]]
            var contains = false
            for el in array {
                if el["event_id"] as! Int == Int(id)! {
                    contains = true
                }
            }
            if !contains {
                array.append(object)
            }
            ua["events_users_notified"] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func removeEventNotified(id: String) {
        var ua = localUserAtrributes()

        if (ua["events_users_notified"] as? [[String: Any]]) == nil {
            ua["events_users_notified"] = [[String: Any]]()
        } else {
            var array = ua["events_users_notified"] as! [[String: Any]]
            array = array.filter { ($0["event_id"] as! Int) != Int(id)! }
            ua["events_users_notified"] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func addUniqueEvent(id: String) {
        var ua = localUserAtrributes()

        if (ua["events_users"] as? [[String: Any]]) == nil {
            ua["events_users"] = [["event_id": Int(id)!, "user_id": Int(self.id!)!]] as! [[String: Any]]
        } else {
            let object: [String: Any] = ["event_id": Int(id)!, "user_id": Int(self.id!)!]
            var array = ua["events_users"] as! [[String: Any]]
            var contains = false
            for el in array {
                if el["event_id"] as! Int == Int(id)! {
                    contains = true
                }
            }
            if !contains {
                array.append(object)
            }
            ua["events_users"] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func removeEvent(id: String) {
        var ua = localUserAtrributes()

        if (ua["events_users"] as? [[String: Any]]) == nil {
            ua["events_users"] = [[String: Any]]()
        } else {
            var array = ua["events_users"] as! [[String: Any]]
            array = array.filter { ($0["event_id"] as! Int) != Int(id)! }
            ua["events_users"] = array
        }
        setLocalUserAttributes(attributes: ua)
    }

    func localUserAtrributes() -> [String: Any] {

        if let ua = AMDDefaults.Standard.getData(key: self.username!+"-userAttributes"),
            let json = dataToJSON(data: ua) {

            return json as! [String: Any]
        }

        return [:]
    }

    public func setLocalUserAttributes(attributes: [String: Any]) {
        if let data = jsonToData(json: attributes) {
            AMDDefaults.Standard.setData(key: self.username!+"-userAttributes", value: data)
        }
    }
}
