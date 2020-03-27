//
//  TileDetailsVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/28/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension TileDetailsViewController {
    
    func fetchHeroImage(tileAsset: AMDAsset) {
        let file = AMDFile(file: tileAsset.aobject!["file"] as! Dictionary<String, Any>, ftype: "photo")
        file.width = Int(UIScreen.main.bounds.width)
        file.height = Int(UIScreen.main.bounds.height)
        file.cacheUrl = file.cacheURLConstructor()
        file.cached = file.checkDoesCacheExist()
        file.cached = false
        file.cacheUrl = nil
        print(file.parsedURL())
        _ = file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
            self.asset.loading = false
            if error == nil {
                if let resim = UIImage(data: data!) {
                    if self.asset.objectId() == tileAsset.objectId() {
                        self.asset.cacheState = "full"
                        self.asset.coverImage = resim
                        self.imageViewHero.image = self.asset.coverImage
                    }
                }
            }
        })
    }
    
    func playVideoFile(tileAsset: AMDAsset){
        if asset.cacheState != "full" && asset.type == "video"  {
            asset.loading = true
            let file = AMDFile(file: asset.aobject!["file"] as! [String: Any], ftype: "video")
            
            file.width = Int(300)
            file.height = Int(300)
            file.quality = 80
            
            file.cacheUrl = file.cacheURLConstructor()
            file.cached = file.checkDoesCacheExist()
            
            _ = file.getDataInBackground(completion: { (error: Error?, _: Data?, cached: Bool) in
                
                if self.asset.objectId() == tileAsset.objectId() {
                    self.asset.loading = false
                    
                    if error == nil {
                        file.type = AMDFileType(rawValue: "video")
                        file.cacheUrl = file.cacheURLConstructor()
                        file.cached = file.checkDoesCacheExist()
                        self.asset.dataURL = file.cacheUrl
                        
                        self.asset.avPlayer = file.dataToVideo_AVPlayer()
                        self.asset.cacheState = "full"
                        
                        self.createVideoPlayerAndPlay()
                        
                    }
                }
            })
        } else {
            createVideoPlayerAndPlay()
        }
    }
    
    func createVideoPlayerAndPlay() {
        let file = AMDFile(file: asset.aobject!["file"] as! Dictionary<String,Any>, ftype: "video")
        file.width = Int(300)
        file.height = Int(300)
        file.quality = 80
        
        file.cacheUrl = file.cacheURLConstructor()
        
        avPlayer = file.dataToVideo_AVPlayer()
        let layer = AVPlayerLayer(player: self.avPlayer)
        layer.frame.origin = CGPoint.zero
        layer.frame.size.width = self.viewMediaWrapper.bounds.width
        layer.frame.size.height = self.viewMediaWrapper.bounds.width*aspectRatio
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.zPosition = 999
        layerAvPlayer = layer
        self.viewMediaWrapper.layer.addSublayer(layer)
        
        if asset.avPlayer != nil && asset.avPlayer != nil && file.format != "jpeg" && file.format != "png" {
            viewVolumeWrapper.isHidden = false
            if !startTime.isValid {
                startTime = CMTime(seconds: 0, preferredTimescale: 1)
            }
            asset.avPlayer!.isMuted = true
            avPlayer.volume = 1
            avPlayer.isMuted = true
            avPlayer.seek(to: startTime)
            avPlayer.play()
            avPlayer.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd(notification:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: avPlayer.currentItem)
        }
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero)
        }
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
    
    @IBAction func actionNext() {
        if avPlayer.isPlaying {
            asset.avPlayer?.isMuted = true
            avPlayer.isMuted = true
        }
        delegate?.tileDetailsNext(tileDetailsVC: self, asset: asset)
    }
    
    @IBAction func actionPrevious() {
        if avPlayer.isPlaying {
            asset.avPlayer?.isMuted = true
            avPlayer.isMuted = true
        }
        delegate?.tileDetailsPrevious(tileDetailsVC: self, asset: asset)
    }
    
    func closeTile()  {
        if avPlayer.isPlaying {
            asset.avPlayer?.isMuted = true
        }
        delegate?.tileDetailsClose()
    }
    
    func showFullDescription() {
        let screenWidth = UIScreen.main.bounds.width
        let heightAsset = asset.orientation == .portrait && !asset.isTwitterStatus ? screenWidth*154/120 : screenWidth
        let difference = UIScreen.main.bounds.height - (108+heightAsset+71+labelDescription.bounds.height)
        if difference < 0 {
            self.layoutConstraintMediaInfoTop.constant = difference-40
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func hideFullDescription() {
        self.layoutConstraintMediaInfoTop.constant = 0
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func actionShare() {
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 1
        }
        performSegue(withIdentifier: "segueTileDetailsShare", sender: nil)
    }
    
    @IBAction func actionClose() {
        closeTile()
    }
    
    @IBAction func showHideDescription() {
        if layoutConstraintMediaInfoTop.constant == 0 {
            showFullDescription()
        } else {
            hideFullDescription()
        }
    }
    
    @IBAction func actionOpenUrl() {
        let browserVC = BrowserViewController.instance()
        if let urlString = self.asset.aobject!["url"] as? String {
            browserVC.url = URL(string: urlString)
            present(browserVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func actionVolume() {
        avPlayer.isMuted = !avPlayer.isMuted
        buttonVolume.isSelected = !avPlayer.isMuted
    }
}
