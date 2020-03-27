//
//  NavigationBarView+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/1/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension NavigationBarView {
    
    @IBAction func actionBack() {
        delegate?.navigationBack()
    }
    
    @IBAction func actionRight() {
        
    }
    
}
