//
//  TutorialViewController+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/3/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension TutorialViewController {
    
    @IBAction func actionSkip() {
        delegate.skipTutorial()
    }
    
    @IBAction func gestureTaken() {
        delegate.gestureTaken(step: step)
    }
    
}
