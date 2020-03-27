//
//  ImprintGridStyle.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

public class ImprintGridStyle {
    
    public var tileBackgroundColor: UIColor = Colors.transparent
    public var presentSplash: Bool = true
    public var headerTitleFont = Fonts.condensedBoldWithSize(size: 20)
    public var headerTitleFontLarge = Fonts.condensedBoldWithSize(size: 36)
    public var headerInfoFont = Fonts.interBold(size: 10)
    public var tileUsernameFont = Fonts.sfSemiBold(size: 14)
    public var tileInfoFont = Fonts.sfSemiBold(size: 10)
    public var tileDescriptionFont = Fonts.sfRegular(size: 16)
    public var buttonActionFont = Fonts.sfSemiBold(size: 15)
    
    public init() {}
    
}
