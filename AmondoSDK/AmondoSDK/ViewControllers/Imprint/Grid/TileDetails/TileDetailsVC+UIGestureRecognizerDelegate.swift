//
//  TileDetailsVC+UIGestureRecognizerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension TileDetailsViewController: UIGestureRecognizerDelegate {
    
    @objc func viewAssetSwipeDown(gesture: UISwipeGestureRecognizer) {
        closeTile()
    }
    @objc  
    func descriptionSwipeUp(gesture: UISwipeGestureRecognizer) {
        if layoutConstraintMediaInfoTop.constant == 0 {
            showFullDescription()
        }
    }
    
    @objc func descriptionSwipeDown(gesture: UISwipeGestureRecognizer) {
        if layoutConstraintMediaInfoTop.constant != 0 {
            hideFullDescription()
        } else  {
            closeTile()
        }
    }
}
