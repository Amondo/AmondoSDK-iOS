//
//  UILabel+Style.swift
//  Amondo
//
//  Created by developer@amondo.com on 7/4/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func styleHeading(text: String) {
        let textAttributes: [NSAttributedString.Key: Any] = [
            (NSAttributedString.Key.font as NSString) as NSAttributedString.Key: Fonts.condensedBoldWithSize(size: 40),
            (NSAttributedString.Key.strokeColor as NSString) as NSAttributedString.Key: Colors.white
        ]
        self.attributedText = NSAttributedString(string: text, attributes: textAttributes)
    }

    func styleInfo() {
        textColor = Colors.silverChalice
        font = Fonts.sfRegular(size: 14)
    }

}
