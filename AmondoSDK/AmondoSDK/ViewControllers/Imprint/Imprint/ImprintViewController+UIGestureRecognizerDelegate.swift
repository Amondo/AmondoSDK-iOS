//
//  ImprintViewController+UIGestureRecognizerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 9/7/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.viewSwipe &&
            otherGestureRecognizer == self.viewPan {
            return true
        }
        return false
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.viewPan {
            if viewPan.direction == Direction.Left || viewPan.direction == Direction.Right {
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
                self.closedImprint()
            } else {
                isDragging=false
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.view.center.x = UIScreen.main.bounds.width/2
                    self.backView.alpha = 1
                    self.view.layer.cornerRadius = 0
                    
                    if self.currentSection == 0 {
                        self.pageControlAssets.alpha = 1
                        self.hideActionButtons()
                    } else if self.currentSection >= self.sections.count {
                        self.pageControlAssets.alpha = 0
                        self.hideActionButtons()
                    } else {
                        self.pageControlAssets.alpha = 1
                        self.showActionButtons()
                    }
                }, completion: nil)
            }
        } else {
            if gesture.direction == Direction.Left || gesture.direction == Direction.Right {
                
                isDragging = true
                
                self.view.center.x = UIScreen.main.bounds.width/2+gesture.translation(in: self.view).x/20
                var scale = abs(gesture.translation(in: self.view).x/2)/100
                if scale > 1 {
                    scale = 1
                }
                let max: CGFloat = 0.15
                self.backView.alpha = 1-scale*max
                self.view.transform = CGAffineTransform(scaleX: 1-scale*max, y: 1-scale*max)
                
                let cr = scale*12
                self.view.layer.cornerRadius = cr
            
                if currentSection == 0 {
                    self.pageControlAssets.alpha = 1-scale
                    self.hideActionButtons()
                } else if currentSection >= sections.count {
                    self.pageControlAssets.alpha = 0
                    self.hideActionButtons()
                } else {
                    self.pageControlAssets.alpha = 1 - scale
                    self.buttonMenu.alpha = 1 - scale
                    self.buttonContribute.alpha = 1 - scale
                    self.visualEffectViewBlurContribute.alpha = 1 - scale
                    self.visualEffectViewBlurMenu.alpha = 1 - scale
                }
            }
        }
    }
    
    @objc func viewPannedContribute(gesture:UIPanGestureRecognizer) {
        if gesture.state == .ended {
            if abs(Int(gesture.translation(in: self.view).y)) > 100 {
                closeUpload()
            }
        }
    }
    
}
