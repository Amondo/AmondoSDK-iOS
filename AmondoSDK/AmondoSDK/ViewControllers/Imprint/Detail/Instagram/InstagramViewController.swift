//
//  InstagramViewController.swift
//  Amondo
//
//  Created by Timothy Whiting on 04/11/2016.
//  Copyright © 2016 Arcopo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import CoreLocation

class InstagramViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var tableViewComments: UITableView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelText: UILabel!
    
    var initialFrame = CGRect(x: 160, y: 320, width: 160, height: 80)
    var transitionImageView = UIImageView()
    var image: UIImage?
    var asset:AMDAsset!
    var transBlur: UIVisualEffectView!
    var headerBlur: UIVisualEffectView!
    
    var imageHeight:CGFloat!
    
    @IBOutlet weak var layoutConstraintPostWrapperTop: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintImageViewFadeBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareReusableViews()
        prepareGestures()
        prepareUI()
        prepareData()
        
        if asset.instagram?.description != nil {
            let descriptionHeight = asset.instagram!.description!.heightForView(Fonts.sfRegular(size: 16), width: self.view.bounds.width-50)
            layoutConstraintPostWrapperTop.constant = -(100+descriptionHeight+10)
        } else {
            layoutConstraintPostWrapperTop.constant = -100
        }

        self.view.layoutIfNeeded()
        let head = tableViewComments.tableHeaderView!
        var newFrame = headerView.bounds;
        newFrame.size.height = UIScreen.main.bounds.size.height
        head.frame = newFrame

        tableViewComments.tableHeaderView = head
        
        if image != nil {
            imageViewHero.image = image
        } else {
            fetchHeroImage()
        }
        transitionImageView.frame = initialFrame
        transitionImageView.contentMode = .scaleAspectFill
        transitionImageView.image = image
        transitionImageView.clipsToBounds = true
        transitionImageView.isUserInteractionEnabled = true
        imageViewHero.isUserInteractionEnabled = true
        self.view.addSubview(transitionImageView)
        
        addBlurViews()
    }
    
    func addBlurViews(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        transBlur = UIVisualEffectView(effect: blurEffect)
        transBlur.frame = transitionImageView.bounds
        transBlur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        transitionImageView.addSubview(transBlur)
        
        headerBlur = UIVisualEffectView(effect: blurEffect)
        headerBlur.frame = imageViewHero.bounds
        headerBlur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageViewHero.addSubview(headerBlur)
        
        if asset.cacheState == "full" {
            self.transBlur.alpha=0
            self.headerBlur.alpha=0
        }
    }
    
    func showAsset(){
        self.image = self.asset.coverImage!
        self.transitionImageView.image = self.image
        self.imageViewHero.image = self.image
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.headerBlur.alpha = 0
            self.transBlur.alpha = 0
        }, completion: nil)
        
    }
    
    func playerItemDidReachEnd(_ notification: Notification) {
        self.avPlayer.seek(to: CMTime.zero)
        self.avPlayer.play()
    }
    
    var avPlayer = AVPlayer()
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" && self.avPlayer.status == .readyToPlay {
            self.avPlayer.play()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialAnimation()
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
