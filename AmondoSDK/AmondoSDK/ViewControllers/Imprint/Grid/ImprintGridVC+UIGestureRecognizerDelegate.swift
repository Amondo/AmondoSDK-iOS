//
//  ImprintGridVC+UIGestureRecognizerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintGridViewController: UIGestureRecognizerDelegate {
    
    @objc func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.gestureSwipe &&
            otherGestureRecognizer == self.gesturePan {
            return true
        }
        return false
    }
    
    @objc func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.gesturePan {
            if gesturePan.direction == Direction.Left || gesturePan.direction == Direction.Right {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
    @objc func viewPanned(gesture:UIPanGestureRecognizer) {
        if gesture.state == .began {
            
        } else if gesture.state == .ended {
            if abs(Int(gesture.translation(in: self.view).x)) > 100 {
                closeImprint()
            }
        }
    }
    
    @objc func viewSwiped(gesture: UISwipeGestureRecognizer) {
        closeImprint()
    }
    
    @objc func viewPannedContribute(gesture:UIPanGestureRecognizer) {
        if gesture.state == .ended {
            if abs(Int(gesture.translation(in: self.view).y)) > 100 {
                closeUpload()
            }
        }
    }
}
