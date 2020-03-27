//
//  UIView+Util.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/31/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}

extension UIView {
    var rootSuperView: UIView {
        var view = self
        while let s = view.superview {
            view = s
        }
        return view
    }
}
