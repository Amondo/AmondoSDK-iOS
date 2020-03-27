//
//  PermissionsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/8/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

protocol PermissionsViewControllerDelegate: NSObjectProtocol {
    
    func permissionsClosed()
    func permissionsApproved()
    
}
