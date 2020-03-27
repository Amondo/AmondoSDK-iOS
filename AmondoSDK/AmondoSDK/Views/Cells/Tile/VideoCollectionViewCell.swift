//
//  VideoCollectionViewCell.swift
//  Amondo
//
//  Created by James Bradley on 09/09/2016.
//  Copyright © 2016 Amondo. All rights reserved.
//

import AVKit
import AVFoundation
import Photos
import UIKit
import MediaPlayer

class VideoCollectionViewCell: UICollectionViewCell {

    // I have put the avplayer layer on this view

    var avPlayer: AVPlayer?
    var avPlayerLayer: AVPlayerLayer?
    var paused: Bool = false
    var indexPath: IndexPath!

    @IBOutlet weak var blur: UIVisualEffectView!
    //This will be called everytime a new value is set on the videoplayer item
    var videoPlayerItem: AVPlayerItem? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            self.avPlayerLayer?.opacity = 0
            let priority = DispatchQueue.GlobalQueuePriority.default
            DispatchQueue.global(priority: priority).async {
                // do some task
                self.avPlayer?.replaceCurrentItem(with: self.videoPlayerItem)
                DispatchQueue.main.async {
                    // update some UI
                    self.avPlayer?.play()

                    UIView.animate(withDuration: 1, animations: {
                        self.avPlayerLayer?.opacity = 1
                    })
                }
            }

            //       avPlayerLayer?.hidden=false

        }
    }

    @objc func playerItemDidReachEnd(_ notification: Notification) {
        self.avPlayer!.currentItem?.seek(to: CMTime.zero)
        self.avPlayer!.play()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        //Setup you avplayer while the cell is created
        self.setupMoviePlayer()
    }

    func setupMoviePlayer() {
        self.avPlayer = AVPlayer(playerItem: self.videoPlayerItem)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)

        avPlayer?.isMuted = true
        avPlayerLayer?.frame = self.bounds
        avPlayerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.layer.addSublayer(avPlayerLayer!)

    }

    func startPlaying() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer?.currentItem)

        self.avPlayer?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(VideoCollectionViewCell.playerItemDidReachEnd(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.avPlayer!.currentItem)
        UIView.animate(withDuration: 1, animations: {
            self.avPlayerLayer?.opacity = 1
        })

        return
            (avPlayer?.play())!

    }

    func stopPlayback() {
        self.avPlayer?.pause()
    }

    func startPlayback() {
        self.avPlayer?.play()
    }

}
