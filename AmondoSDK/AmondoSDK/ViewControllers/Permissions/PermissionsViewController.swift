//
//  PermissionsViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/6/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

enum PermissionType: Int {
    case camera
    case notifications
}

class PermissionsViewController: UIViewController {
    
    @IBOutlet var visualEffectViewBlur: UIVisualEffectView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var labelHeading: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var viewActionsWrapper: UIView!
    @IBOutlet var buttonNope: UIButton!
    @IBOutlet var buttonSure: UIButton!
    @IBOutlet var buttonSettings: UIButton!
    @IBOutlet var buttonClose: UIButton!
    
    @IBOutlet var layoutConstraintHeadingBottom: NSLayoutConstraint!
    @IBOutlet var layoutConstraintActionsBottom: NSLayoutConstraint!

    var viewNotification: NotificationView?
    var noMedia: Bool = false
    var type: PermissionType!
    var delegate: PermissionsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
        prepareGfx()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBlur()
    }
    
    static func instance(type: PermissionType) -> PermissionsViewController {
        let vcInstance = PermissionsViewController(nibName: "PermissionsViewController", bundle: Bundle(for: PermissionsViewController.self))
        vcInstance.type = type
        vcInstance.modalTransitionStyle = .coverVertical
        vcInstance.modalPresentationStyle = .overCurrentContext
        return vcInstance
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
