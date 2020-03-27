//
//  ItemArticleVC+UIGestureRecognizerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ItemArticleViewController: UIGestureRecognizerDelegate {
    
    @objc func viewPannedPlayer(gesture:UIPanGestureRecognizer) {
        if gesture.state == .began {
            
        } else if gesture.state == .ended {
            if abs(Int(gesture.translation(in: self.view).x)) > 100 || abs(Int(gesture.translation(in: self.view).y)) > 100 {
                self.closeAnimation()
            }
        }
    }
    
    func viewPannedInfo(gesture:UIPanGestureRecognizer) {
        if gesture.state == .began {
            
        } else if gesture.state == .ended {
            if abs(Int(gesture.translation(in: self.view).x)) > 100 {
                self.closeAnimation()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
