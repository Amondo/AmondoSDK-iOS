//
//  TutorialViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/3/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

protocol TutorialViewControllerDelegate: class {
    
    func skipTutorial()
    func dismissTutorial()
    func gestureTaken(step: TutorialStep)
    
}
