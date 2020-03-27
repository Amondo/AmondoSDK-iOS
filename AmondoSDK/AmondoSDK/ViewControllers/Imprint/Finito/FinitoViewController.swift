//
//  FinitoViewController.swift
//  Amondo
//
//  Created by Timothy Whiting on 12/03/2017.
//  Copyright © 2017 Arcopo. All rights reserved.
//

import UIKit
import Intercom

class FinitoViewController: UIViewController {
    
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var labelFinito: UILabel!
    @IBOutlet weak var labelWhatsNext: UILabel!
    @IBOutlet weak var tableViewOptions: UITableView!
    @IBOutlet weak var visualEffectViewBlurOverview: UIVisualEffectView!
    
    @IBOutlet var layoutConstraintOptionsBottom: NSLayoutConstraint!
    
    let options: [ImprintActionType] = [.viewAgain, .chat, .backToGallery]
    var currentImprint: AMDImprintItem!
    var delegate: FinitoViewControllerDelegate?
    
    static func instance() -> FinitoViewController {
        let vcInstance = FinitoViewController(nibName: "FinitoViewController", bundle: Bundle(for: FinitoViewController.self))
        vcInstance.modalTransitionStyle = .coverVertical
        vcInstance.modalPresentationStyle = .overCurrentContext
        vcInstance.view.layoutIfNeeded()
        return vcInstance
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareReusableViews()
        prepareUI()
    }
}
