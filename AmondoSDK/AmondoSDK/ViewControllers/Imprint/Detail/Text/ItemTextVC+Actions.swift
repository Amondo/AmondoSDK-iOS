//
//  ItemTextVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/7/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ItemTextViewController {
    
    func prepareForInitialAnimtion(){
        imageViewText.alpha = 0
        viewInfo.alpha = 0
        transitionImageView.alpha = 1
        if (UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688){
            imageViewText.layer.cornerRadius = 10
        } else {
            imageViewText.roundCorners(corners: [.topLeft , .topRight] , radius: 10)
        }
        
        imageViewText.layer.masksToBounds = true
    }
    
    func initialAnimation(){
        self.transitionImageView.alpha = 1
        var yPosition = 62
        if UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688 {
            yPosition = 42
        }  else {
            yPosition = 22
        }
        

        UIView.animate(withDuration: 0.4, animations: {
            self.transitionImageView.frame.origin = CGPoint(x: 0, y: yPosition)
            self.transitionImageView.frame.size = CGSize(width: self.view.bounds.width,height: self.layoutConstraintImageViewHeight.constant)
            self.viewInfo.alpha = 1
        }, completion: { (b:Bool) in
            self.imageViewText.alpha = 1
            self.transitionImageView.alpha = 0
        })
    }
    
    @objc
    func closeAnimation(){
        closing = true
        let parent = self.parent as! ImprintViewController
        parent.view.isUserInteractionEnabled = false
        parent.showCells()
        var yPosition = 62
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height != 2436 {
            yPosition = 42
        }

        imageViewText.alpha = 0
        viewBackground.alpha = 0
        transitionImageView.alpha = 1
        transitionImageView.frame.origin.y = CGFloat(yPosition)
        UIView.animate(withDuration: 0.4, animations: {
            self.viewInfo.alpha = 0
            self.transitionImageView.frame = self.initialFrame
        }, completion: { (b:Bool) in
            self.view.removeFromSuperview()
            for layer in self.view.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
            parent.view.isUserInteractionEnabled = true
            parent.showImprintActions()
        })
    }
    
}
