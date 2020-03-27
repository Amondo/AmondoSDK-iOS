//
//  Fonts.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/31/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

struct Fonts {

    static func condensedBoldWithSize(size: CGFloat) -> UIFont {
        return UIFont(name: "DINPro-CondensedBold", size: size)!
    }

    static func systemMediumWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }

    static func systemRegularWithSize(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
    }
    
    
    static func menu() -> UIFont {
        return UIFont(name: "SFProText-Bold", size: 14)!
    }
    
    static func sfSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-SemiBold", size: size)!
    }
    
    static func sfBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Bold", size: size)!
    }
    
    static func sfRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SFProText-Regular", size: size)!
    }
    
    static func interRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size)!
    }
    
    static func interBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size)!
    }
}
