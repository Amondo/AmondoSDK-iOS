//
//  ItemArticleViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

class ItemArticleViewController: UIViewController {
    
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewImageWrapper: UIView!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var buttonOpen: UIButton!
    
    var transBlur: UIVisualEffectView!
    var headerBlur: UIVisualEffectView!
    var initialFrame = CGRect(x: 160, y: 320, width: 160, height: 80)
    var transitionImageView = UIImageView()
    var image:UIImage? = UIImage()
    var asset:AMDAsset!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGestures()
        prepareUI()
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
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
