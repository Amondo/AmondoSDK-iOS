//
//  GridHeaderReusableView+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/30/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension GridHeaderReusableView {
    
    func hideHeroImage() {
        layoutConstraintInfoBottom.constant = 20.0
        imageViewCover.isHidden = true
        buttonClose.isHidden = false
        labelInfo.alpha = 1
        labelTitle.alpha = 1
        UIView.animate(withDuration: 1.2) {
            self.labelTitle.font = self.gridStyle.headerTitleFont
        }
        layoutIfNeeded()
    }
    
    func showHeroImage() {
        if firstRender == false {
            firstRender = true
        }
        if #available(iOS 11.0, *) {
            if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(0.0)) {
                layoutConstraintInfoBottom.constant = 42.0
            } else {
                layoutConstraintInfoBottom.constant = 20.0
            }
        }
        imageViewCover.isHidden = false
        buttonClose.isHidden = true
        labelInfo.alpha = firstRender ? 1 : 0
        labelTitle.alpha = firstRender ? 1 : 0
        UIView.animate(withDuration: 1.2) {
            self.labelTitle.font = self.gridStyle.headerTitleFontLarge
        }
        layoutIfNeeded()
    }
    
    func updateProgress(progress: CGFloat) {
        layoutConstraintProgressTrailing.constant = progress
        layoutIfNeeded()
    }
    
    func animateTitle(opacity: CGFloat) {
        if !imageViewCover.isHidden {
            labelTitle.alpha = opacity
            labelInfo.alpha = opacity
        }
    }
    
    @IBAction func actionClose() {
        NotificationCenter.default.post(name: Notification.Name("ImprintClose"), object: nil)
    }
}
