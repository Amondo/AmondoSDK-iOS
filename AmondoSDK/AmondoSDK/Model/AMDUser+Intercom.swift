//
//  AMDUser+Intercom.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import Intercom

extension AMDUser {

    func intercomRegister () {
        Intercom.registerUser(withEmail: username!)

        let name = firstName! + " " + (lastName ?? "")
        let fname = firstName!
        let email = username!

        let iuserAttributes = ICMUserAttributes()
        iuserAttributes.name = name
        iuserAttributes.email = email

        var id = ""

        if let amdUserId = AMDUser.currentUser()?.id {
            id = amdUserId
        }

        var attributes = ["first name": fname,
                          "UserID": id]

        if let lastName = lastName {
            attributes["last name"] = lastName
        }

        iuserAttributes.customAttributes = attributes

        Intercom.updateUser(iuserAttributes)
    }
}
