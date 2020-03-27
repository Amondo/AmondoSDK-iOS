//
//  ItemTextViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/7/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

class ItemTextViewController: UIViewController {
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var imageViewText: UIImageView!
    @IBOutlet weak var imageViewUserAvatar: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    
    @IBOutlet weak var layoutConstraintImageViewHeight: NSLayoutConstraint!
    
    var initialFrame = CGRect(x: 160, y: 320, width: 160, height: 80)
    var transitionImageView = UIImageView()
    var image:UIImage? = UIImage()
    var asset:AMDAsset!
    var closing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGestures()
        prepareGfx()
        prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareForInitialAnimtion()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialAnimation()
    }
}
