//
//  AMDSharedImprint.swift
//  Amondo
//
//  Created by developer@amondo.com on 9/7/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

class AMDSharedImprints {
    class func saveShared(id:String){
        UserDefaults.standard.set(true, forKey: AMDUser.currentUser()!.id!+"-UserSharedImprint-"+id)
    }
    class func deleteShared(id:String){
        UserDefaults.standard.set(nil, forKey: AMDUser.currentUser()!.id!+"-UserSharedImprint-"+id)
    }
    class func hasAlreadyShared(id:String) -> Bool {
        if let has = UserDefaults.standard.value(forKey: AMDUser.currentUser()!.id!+"-UserSharedImprint-"+id) {
            return true
        }
        return false
    }
}
