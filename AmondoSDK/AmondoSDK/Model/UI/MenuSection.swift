//
//  MenuSection.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/3/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation

class MenuSection: NSObject {
    
    var name:String!
    var type:String!
    var state = "genres"
    var items = [AMDImprintItem]()
    var genres: [AMDGenre]?
    var selectedGenre:Int? = 0
    
}
