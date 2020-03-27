//
//  TutorialViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/3/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

enum TutorialStep {
    case exploreImprint
    case openTile
    case closeTile
    case contribute
}

class TutorialViewController: UIViewController {
    
    @IBOutlet var viewWrapper: UIView!
    @IBOutlet var buttonSkip: UIButton!
    @IBOutlet var viewCenter: UIView!
    @IBOutlet var imageViewHand: UIImageView!
    @IBOutlet var viewBox: UIView!
    @IBOutlet var labelBoxEmoji: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var viewContribute: UIView!
    @IBOutlet var buttonContribute: UIButton!
    
    @IBOutlet var layoutConstraintBoxBottom: NSLayoutConstraint!
    @IBOutlet var layoutConstraintContributeBottom: NSLayoutConstraint!
    
    var step: TutorialStep!
    var delegate: TutorialViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareData()
        prepareGestures()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    static func instance(step: TutorialStep) -> TutorialViewController {
        let vcInstance = TutorialViewController(nibName: "TutorialViewController", bundle: Bundle(for: TutorialViewController.self))
        vcInstance.step = step
        vcInstance.modalTransitionStyle = .crossDissolve
        vcInstance.modalPresentationStyle = .overCurrentContext
        return vcInstance
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

