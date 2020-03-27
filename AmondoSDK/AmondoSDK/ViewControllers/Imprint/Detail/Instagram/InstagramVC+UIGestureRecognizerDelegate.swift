//
//  InstagramVC+UIGestureRecognizerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/30/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension InstagramViewController: UIGestureRecognizerDelegate {
    
    @objc func viewPanned(gesture:UIPanGestureRecognizer) {
        if gesture.state == .began {
            
        } else if gesture.state == .ended {
            if abs(Int(gesture.translation(in: self.view).x)) > 100 || abs(Int(gesture.translation(in: self.view).y)) > 100 {
                self.closeAnimation()
            }
        }
    }
    
}
