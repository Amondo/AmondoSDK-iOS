//
//  ImprintGridVC+FinitoViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/1/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintGridViewController: FinitoViewControllerDelegate {
    
    func finitoClose() {
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 0
        }
        showActionButtons()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func finitoShare() {
        hideActionButtons()
        
        self.navigationController?.dismiss(animated: false, completion: {
            self.performSegue(withIdentifier: "segueImprintShare", sender: nil)
        })
    }
    
    func finitoViewAgain() {
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 0
        }
        self.navigationController?.dismiss(animated: true, completion: {
            self.hideActionButtons()
            self.collectionViewImprint.setContentOffset(CGPoint(x: 0, y: UIScreen.main.bounds.height-self.heightHeader), animated: true)
        })
    }
}

