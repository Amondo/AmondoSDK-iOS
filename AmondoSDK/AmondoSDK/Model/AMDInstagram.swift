//
//  AMDInstagram.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

class AMDInstagram {
    var geopoint: [Double]?
    var description: String?
    var username: String?
    var location: String?
    var likes: Int = 0
    var source: String?
    var comments: [[String: AnyObject]] = []
}
