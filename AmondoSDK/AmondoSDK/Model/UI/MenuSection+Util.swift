//
//  MenuSection+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/3/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension MenuSection {
    
    static func menuSectionFromCategories(categories: [AMDCategory]?) -> [MenuSection] {
        var sections = [MenuSection]()
        
        for category in categories! {
            let sec = MenuSection()
            
            sec.type = category.type.rawValue
            sec.name = category.label
            
            if sec.type == AMDCategoryType.genre.rawValue {
                let genres = category.genres as! [Dictionary<String,Any>]
                sec.genres = category.genres
            } else {
                sec.items = category.events
                sec.items.sort { (item1, item2) -> Bool in
                    let t1 = item1.event?.date ?? Date.distantPast
                    let t2 = item2.event?.date ?? Date.distantFuture
                    return t1 > t2
                }
            }
            sections.append(sec)
        }
        
        return sections
    }

}
