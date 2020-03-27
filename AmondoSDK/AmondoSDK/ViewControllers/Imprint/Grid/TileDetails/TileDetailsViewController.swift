//
//  TileDetails.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/27/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class TileDetailsViewController: UIViewController {
    
    @IBOutlet weak var viewAssetWrapper: UIView!
    @IBOutlet weak var viewMediaWrapper: UIView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var visualEffectViewBlurOverview: UIVisualEffectView!
    @IBOutlet weak var viewOpenWrapper: UIView!
    @IBOutlet weak var buttonOpenUrl: UIButton!
    @IBOutlet weak var viewVolumeWrapper: UIView!
    @IBOutlet weak var buttonVolume: UIButton!
    
    var gestureSwipeInfoUp:UISwipeGestureRecognizer!
    var gestureSwipeInfoDown:UISwipeGestureRecognizer!
    var gestureSwipeAsset:UISwipeGestureRecognizer!
    
    @IBOutlet weak var layoutConstraintMediaWrapperHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintMediaInfoTop: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintMediaInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintContentTop: NSLayoutConstraint!
    
    var image: UIImage?
    var imprint:AMDImprintItem!
    var asset:AMDAsset!
    var avPlayer = AVPlayer()
    var layerAvPlayer: CALayer?
    var startTime = CMTime()
    var fadeUp = false
    var fadeDown = false
    var aspectRatio: CGFloat!
    var heightHeader: CGFloat!
    var gridStyle: ImprintGridStyle =  ImprintGridStyle()
    var delegate: TileDetailsViewControllerDelegate?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImprintActionsViewController {
            vc.isJustShare = true
            vc.imprint =  imprint
            vc.asset = asset
            vc.delegate  = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGestures()
        prepareUI()
        prepareData()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playVideoFile(tileAsset: asset)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fadeVolumeDown()
    }
    
    func refresh() {
        layerAvPlayer?.removeFromSuperlayer()
        imageViewHero.image = nil
        if layerAvPlayer != nil {
            layerAvPlayer?.removeFromSuperlayer()
        }
        prepareUI()
        prepareData()
        playVideoFile(tileAsset: asset)
    }
    
    func playerItemDidReachEnd(_ notification: Notification) {
        self.avPlayer.seek(to: CMTime.zero)
        self.avPlayer.play()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" && self.avPlayer.status == .readyToPlay {
            self.avPlayer.play()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
