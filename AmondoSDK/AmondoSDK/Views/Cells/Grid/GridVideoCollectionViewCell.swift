//
//  GridVideoCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/22/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import MediaPlayer

class GridVideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var visualEffectViewBlur: UIVisualEffectView!
    @IBOutlet weak var viewAudioVideoPlayerWrapper: UIView!
    
    var item: AMDAsset!
    var audioVideoPlayer: AVPlayer?
    var audioVideoPlayerLayer: AVPlayerLayer?
    var paused: Bool = false
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    var videoPlayerItem: AVPlayerItem? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            self.audioVideoPlayerLayer?.opacity = 0
            
            DispatchQueue.global(qos: .background).async {
                self.audioVideoPlayer?.replaceCurrentItem(with: self.videoPlayerItem)
                DispatchQueue.main.async {
                    self.audioVideoPlayer?.play()
                    
                    UIView.animate(withDuration: 1, animations: {
                        self.audioVideoPlayerLayer?.opacity = 1
                    })
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareAudioVideoPlayer()
    }
    
    func prepareCell() {
        if self.item.avPlayer == nil {
            self.audioVideoPlayer = AVPlayer()
            if self.audioVideoPlayerLayer != nil {
                self.audioVideoPlayerLayer!.removeFromSuperlayer()
            }
            
            viewWrapper.backgroundColor = gridStyle.tileBackgroundColor
            
            if self.item.loading == false {
                self.item.loading = true
                let file = AMDFile(file: self.item.aobject!["file"] as! [String: Any], ftype: "video")
                
                file.width = Int(300)
                file.height = Int(300)
                file.quality = 80
                
                file.cacheUrl = file.cacheURLConstructor()
                file.cached = file.checkDoesCacheExist()
                
                _ = file.getDataInBackground(completion: { (error: Error?, _: Data?, cached: Bool) in
                    self.item.loading = false
                    
                    if error == nil {
                        file.type = AMDFileType(rawValue: "video")
                        file.cacheUrl = file.cacheURLConstructor()
                        file.cached = file.checkDoesCacheExist()
                        self.item.dataURL = file.cacheUrl
                        
                        self.item.avPlayer = file.dataToVideo_AVPlayer()
                        self.item.cacheState = "full"
                        
                        self.audioVideoPlayer = self.item.avPlayer!
                        self.playWithAudioVideoPlayer(self.item.avPlayer!)
                        
                        UIView.animate(withDuration: 0.3, animations: {
                            self.visualEffectViewBlur.alpha = 0
                        })
                        
                    }
                })
            }
        } else {
            self.audioVideoPlayer = self.item.avPlayer!
            self.playWithAudioVideoPlayer(self.item.avPlayer!)
            self.audioVideoPlayer!.play()
            
            UIView.animate(withDuration: 0.3, animations: {
                self.visualEffectViewBlur.alpha = 0
            })
        }
    }
    
    func prepareAudioVideoPlayer() {
        self.audioVideoPlayer = AVPlayer(playerItem: self.videoPlayerItem)
        self.audioVideoPlayerLayer = AVPlayerLayer(player: audioVideoPlayer)
        
        self.audioVideoPlayer?.isMuted = true
        self.audioVideoPlayerLayer?.frame = self.viewAudioVideoPlayerWrapper.bounds
        self.audioVideoPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.viewAudioVideoPlayerWrapper.layer.addSublayer(self.audioVideoPlayerLayer!)
    }
    
    func playWithAudioVideoPlayer(_ avPlayer: AVPlayer) {
        if self.audioVideoPlayerLayer != nil {
            self.audioVideoPlayerLayer?.removeFromSuperlayer()
        }
        avPlayer.seek(to: CMTime.zero)
        self.audioVideoPlayerLayer = AVPlayerLayer(player: avPlayer)
        self.audioVideoPlayerLayer?.frame = self.bounds
        self.audioVideoPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        self.viewAudioVideoPlayerWrapper!.layer.addSublayer(self.audioVideoPlayerLayer!)
        
        avPlayer.isMuted = true
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.audioVideoPlayer?.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(GridVideoCollectionViewCell.playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.audioVideoPlayer!.currentItem)
    }
    
    func startPlaying() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.audioVideoPlayer?.currentItem)
        
        self.audioVideoPlayer?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(GridVideoCollectionViewCell.playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.audioVideoPlayer!.currentItem)
        UIView.animate(withDuration: 1, animations: {
            self.audioVideoPlayerLayer?.opacity = 1
        })
    }
    
    func stopPlayback() {
        self.audioVideoPlayer?.pause()
    }
    
    func startPlayback() {
        self.audioVideoPlayer?.play()
    }
    
    @objc func playerItemDidReachEnd(_ notification: Notification) {
        self.audioVideoPlayer!.currentItem?.seek(to: CMTime.zero)
        self.audioVideoPlayer!.play()
    }
    
}
