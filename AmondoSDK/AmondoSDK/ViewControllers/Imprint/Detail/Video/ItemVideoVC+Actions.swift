
//
//  ItemVideoVC+Actions.swift
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

extension ItemVideoViewController {
    
    func prepareForInitialAnimtion(){
        viewPlayerWrapper.alpha = 0
        transitionImageView.alpha = 1
        viewPlayerWrapper.layer.cornerRadius = 10
        viewPlayerWrapper.layer.masksToBounds = true
    }
    
    func initialAnimation(){
        self.transitionImageView.alpha = 1
        var yPosition = 62
        if UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688 {
            yPosition = 42
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.transitionImageView.frame.origin = CGPoint(x: 0, y: yPosition)
            self.transitionImageView.frame.size = CGSize(width: self.viewPlayerWrapper.bounds.width,height: self.viewPlayerWrapper.bounds.height)
            self.viewPlayerWrapper.alpha = 1
            self.viewInfo.alpha = 1
        }, completion: { (b:Bool) in
            self.transitionImageView.alpha = 0
        })
    }
    
    @objc func closeAnimation(){
        closing = true
        let parent = self.parent as! ImprintViewController
        parent.view.isUserInteractionEnabled = false
        parent.showCells()
        var yPosition = 62
        if UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688 {
            yPosition = 42
        }
        
        if avPlayer != nil {
            fadeVolumeDown()
        }
        
        imageViewHero.alpha = 0
        viewBackground.alpha = 0
        transitionImageView.alpha = 1
        transitionImageView.frame.origin.y = CGFloat(yPosition)
        UIView.animate(withDuration: 0.4, animations: {
            self.viewWrapper.alpha = 0
            self.transitionImageView.frame = self.initialFrame
        }, completion: { (b:Bool) in
            self.view.removeFromSuperview()
            for layer in self.view.layer.sublayers! {
                layer.removeFromSuperlayer()
            }
            parent.view.isUserInteractionEnabled = true
            parent.showImprintActions()
        })
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
            self.transBlur.alpha = 0
            self.headerBlur.alpha = 0
        }
    }
    
    func showAsset(){
        self.avPlayer = self.asset.avPlayer
        delayedPlayVideo()
        self.avPlayer.isMuted = false
        self.asset.avPlayer!.isMuted = false
        self.avPlayer.volume = 0
        self.avPlayer.isMuted = false
        self.asset.avPlayer!.play()
        self.fadeVolumeUp()
        
        self.image = self.asset.coverImage!
        self.transitionImageView.image = self.image
        self.imageViewHero.image = self.image
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.headerBlur.alpha = 0
            self.transBlur.alpha = 0
        }, completion: nil)
    }
    
    func delayedPlayVideo(){
        let layer = AVPlayerLayer(player: self.avPlayer)
        layer.frame.origin = CGPoint.zero
        layer.frame.size.width = self.view.bounds.width
        layer.frame.size.height = self.view.bounds.width*aspectRatio
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.viewPlayerWrapper.layer.addSublayer(layer)
    }
    
    func playVideoFile(){
        if asset.cacheState != "full" || self.avPlayer == nil {
            return
        } else {
            self.transBlur.alpha = 0
            self.headerBlur.alpha = 0
        }
        
        let layer = AVPlayerLayer(player: self.avPlayer)
        layer.frame.origin = CGPoint.zero
        layer.frame.size.width = self.viewPlayerWrapper.bounds.width
        layer.frame.size.height = self.viewPlayerWrapper.bounds.width*aspectRatio
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.viewPlayerWrapper.layer.addSublayer(layer)
        
        self.asset.avPlayer!.isMuted = false
        self.avPlayer.volume = 0
        self.avPlayer.isMuted = false
        self.fadeVolumeUp()
    }
    
    func fadeVolumeDown() {
        fadeDown = true
        if avPlayer.volume > 0.1 {
            avPlayer.volume = avPlayer.volume - 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.028) {
                self.fadeVolumeDown()
            }
        } else {
            avPlayer.volume = 0.0
            avPlayer.isMuted = true
            avPlayer.seek(to: CMTime.zero)
            fadeDown = false
        }
    }
    
    func fadeVolumeUp() {
        if fadeDown {
            return
        }
        fadeUp = true
        if avPlayer.volume < 0.95 {
            avPlayer.volume = avPlayer.volume + 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
                self.fadeVolumeUp()
            }
        } else {
            fadeUp = false
            avPlayer.volume = 1.0
        }
    }
    
    @IBAction func actionOpenAssetSource() {
        let location = asset.aobject?["url"] as? String
        UIApplication.shared.open(URL.init(string: location ?? "")!, options: [:], completionHandler: nil)
    }
}
