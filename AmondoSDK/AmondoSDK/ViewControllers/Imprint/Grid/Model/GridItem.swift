//
//  GridItem.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/16/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class GridItem {
    
    enum GridItemType: String {
        case square
        case portrait
        case group
        case scroller
    }
    
    var content: Any! //can be AMDAsset, [AMDAsset]
    var type: GridItemType!
    var height: CGFloat!
    var width: CGFloat!
    
    init(content: Any, type: GridItemType, height: CGFloat, width: CGFloat) {
        self.content = content
        self.type = type
        self.height = height
        self.width = width
    }
    
}
