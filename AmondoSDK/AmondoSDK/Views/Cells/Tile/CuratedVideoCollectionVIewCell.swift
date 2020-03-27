//
//  CuratedVideoCollectionVIewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
import Photos
import UIKit
import MediaPlayer

class CuratedVideoCollectionViewCell: UICollectionViewCell {
    
    var avPlayer = AVPlayer()
    var avPlayerLayer: AVPlayerLayer!
    
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var imageViewFrame: UIImageView!
    var indexPath: IndexPath!
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    override func awakeFromNib() {
        
    }
    
    func startPlaying() {
        
        self.avPlayer.play()
        
    }
    
    func clearAvPlayer() {
        self.avPlayer = AVPlayer()
        if self.avPlayerLayer != nil {
            self.avPlayerLayer.removeFromSuperlayer()
        }
    }
    
    func playAvPlayer(_ avPlayer: AVPlayer) {
        
        if self.avPlayerLayer != nil {
            self.avPlayerLayer.removeFromSuperlayer()
        }
        avPlayer.seek(to: CMTime.zero)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.frame = self.bounds
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        //     avPlayerLayer.backgroundColor=UIColor.redColor().CGColor
        
        self.layer.addSublayer(avPlayerLayer)
        
        avPlayer.isMuted = true
        //    avPlayer.pause()
        
        //    avPlayerLayer.hidden=false
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(VideoCollectionViewCell.playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer.currentItem)
    }
    
    func playVideoFile(_ video: AVPlayerItem?, avPlayerAMD: AVPlayer?, url: String?) {
        
        let start = Date()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        
        self.alpha = 0
        
        if self.avPlayerLayer != nil {
            self.avPlayerLayer.removeFromSuperlayer()
        }
        
        //     self.avPlayerLayer = AVPlayerLayer(player: avPlayerAMD)
        
        //     self.avPlayerLayer.videoGravity=AVLayerVideoGravityResizeAspectFill
        
        self.avPlayer = avPlayerAMD!
        
        self.avPlayerLayer = AVPlayerLayer(player: avPlayer)
        
        self.avPlayerLayer.frame = self.bounds
        
        self.avPlayerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(self.avPlayerLayer)
        
        self.avPlayer.isMuted = true
        self.avPlayer.pause()
        
        //     avPlayerAMD?.play()
        avPlayer.isMuted = true
        print("time diff 3:\(Date().timeIntervalSince(start))")
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
        }, completion: { (_: Bool) in
            //     self.avPlayer.play()
        })
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(VideoCollectionViewCell.playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer.currentItem)
        
        return
        
    }
    
    @objc func playerItemDidReachEnd(_ notification: Notification) {
        
        let ob = notification.object as? AVPlayerItem
        if ob != nil {
            if ob! == self.avPlayer.currentItem {
                self.avPlayer.seek(to: CMTime.zero)
                self.avPlayer.play()
            }
        }
    }
    
}
