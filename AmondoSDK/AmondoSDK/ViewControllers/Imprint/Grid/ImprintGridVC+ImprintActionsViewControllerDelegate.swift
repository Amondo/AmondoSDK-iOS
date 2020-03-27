//
//  ImprintGridVC+ImprintActionsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/1/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintGridViewController: ImprintActionsViewControllerDelegate {
    
    func imprintActionsClosed() {
        showActionButtons()
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 0
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func imprintActionsClosedJustShare() {
        self.navigationController?.dismiss(animated: false, completion: {
            self.showFinito(animated: true)
        })
    }
    
}
