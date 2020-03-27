//
//  ImprintVC+ImprintActionsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension ImprintViewController: ImprintActionsViewControllerDelegate {
    
    func imprintActionsClosed() {
        actionCloseMenu()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func imprintActionsClosedJustShare() {
        //actionCloseMenu()
        self.navigationController?.dismiss(animated: false, completion: {
            self.showFinito(animated: true)
        })
    }
    
}
