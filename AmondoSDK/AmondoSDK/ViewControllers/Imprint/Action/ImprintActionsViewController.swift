//
//  ImprintActionsViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class ImprintActionsViewController: UIViewController {
    
    @IBOutlet var viewWrapper: UIView!
    @IBOutlet var viewOptionsWrapper: UIView!
    @IBOutlet var tableViewActions: UITableView!
    
    @IBOutlet var layoutConstraintOptionsBottom: NSLayoutConstraint!
    
    var imprint: AMDImprintItem!
    var asset: AMDAsset?
    var shareText = ""
    var customurl: String!
    var delegate: ImprintActionsViewControllerDelegate?
    var isShareOpen: Bool = false
    var isJustShare: Bool = false
    let options: [ImprintActionType] = [.share, .chat, .report, .cancel ]
    let share: [ImprintActionType] = [.messages, .whatsapp, .messanger, .facebook, .twitter, .link, .more, .cancel ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareReusableViews()
        prepareUI()
        prepareData()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
