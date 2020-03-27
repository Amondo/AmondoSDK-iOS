//
//  ItemVideoViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/20/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import Photos

class ItemVideoViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var viewPlayerWrapper: UIView!
    @IBOutlet weak var imageViewUserAvatar: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonOpen: UIButton!
    
    @IBOutlet weak var layoutConstraintVideoWrapperHeight: NSLayoutConstraint!
    
    var transBlur: UIVisualEffectView!
    var headerBlur: UIVisualEffectView!
    var initialFrame = CGRect(x: 160, y: 320, width: 160, height: 80)
    var transitionImageView = UIImageView()
    var image:UIImage? = UIImage()
    var asset:AMDAsset!
    var closing = false
    var fadeUp = false
    var fadeDown = false
    var avPlayer: AVPlayer!
    var startTime = CMTime()
    var aspectRatio:CGFloat!
    
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
        playVideoFile()
    }
    
}
