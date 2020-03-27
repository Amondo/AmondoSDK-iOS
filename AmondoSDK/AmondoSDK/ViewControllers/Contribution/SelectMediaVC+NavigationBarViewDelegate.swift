//
//  SelectMediaVC+NavigationBarViewDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension SelectMediaViewController: NavigationBarViewDelegate {
    
    func navigationBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
