//
//  TileDetailsVC+ImprintActionsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/8/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension TileDetailsViewController: ImprintActionsViewControllerDelegate {
    
    func imprintActionsClosed() {
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 0
        }
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func imprintActionsClosedJustShare() {
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
