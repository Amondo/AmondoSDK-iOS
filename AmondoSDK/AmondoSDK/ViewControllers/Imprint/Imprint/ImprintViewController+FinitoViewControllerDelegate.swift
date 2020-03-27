//
//  ImprintViewController+FinitoViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/22/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintViewController: FinitoViewControllerDelegate {
    
    func finitoClose() {
        actionCloseMenu()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func finitoShare() {
        self.buttonMenu.alpha = 0
        self.visualEffectViewBlurMenu.alpha = 0
        self.buttonContribute.alpha = 0
        self.visualEffectViewBlurContribute.alpha = 0
        
        self.navigationController?.dismiss(animated: false, completion: {
            self.isMenuOpen = false
            self.performSegue(withIdentifier: "segueImprintShare", sender: nil)
        })
    }
    
    func finitoViewAgain() {
        actionCloseMenu()
        self.hideActionButtons()
        self.navigationController?.dismiss(animated: true, completion: {
            self.hideActionButtons()
        })
    }
}
