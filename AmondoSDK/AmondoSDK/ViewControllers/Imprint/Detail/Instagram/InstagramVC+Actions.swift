//
//  InstagramVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/5/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension InstagramViewController {
    
    @objc func initialAnimation() {
        imageViewHero.alpha = 0
        self.transitionImageView.alpha = 1
        tableViewComments.frame.origin.y = self.view.bounds.height-imageViewHero.bounds.height
        headerView.frame.origin.y = self.view.bounds.height-imageViewHero.bounds.height
        
        UIView.animate(withDuration: 0.4, animations: {
            self.headerView.frame.origin.y = 0
            self.tableViewComments.frame.origin.y = 0
            self.transitionImageView.frame.origin = CGPoint.zero
            self.transitionImageView.frame.size = CGSize(width: self.view.bounds.width,height: UIScreen.main.bounds.size.height)
        }, completion: { (b:Bool) in
            self.headerView.alpha = 1
            self.imageViewHero.alpha = 1
            self.transitionImageView.alpha = 0
            UIView.animate(withDuration: 0.25) {
                self.headerBackgroundView.alpha = 1
                self.viewInfo.alpha = 1
            }
        })
    }
    
    @objc func closeAnimation() {
        let parent = self.parent as! ImprintViewController
        parent.view.isUserInteractionEnabled = false
        parent.showCells()
        
        imageViewHero.alpha = 0
        transitionImageView.alpha = 1
        transitionImageView.frame.origin.y = headerView.frame.origin.y
        UIView.animate(withDuration: 0.25) {
            self.headerView.alpha = 0
        }
        UIView.animate(withDuration: 0.4, animations: {
            self.tableViewComments.frame.origin.y = self.view.bounds.height-self.imageViewHero.bounds.height
            self.transitionImageView.frame = self.initialFrame
            self.tableViewComments.contentOffset.y = 0
            self.headerView.frame.origin.y = self.view.bounds.height-self.imageViewHero.bounds.height
        }, completion: { (b:Bool) in
            self.view.removeFromSuperview()
            parent.view.isUserInteractionEnabled = true
            parent.showImprintActions()
        })
    }
    
    func fetchHeroImage() {
        let file = AMDFile(file: asset.aobject!["file"] as! Dictionary<String, Any>, ftype: "photo")
        file.width = Int(UIScreen.main.bounds.width)
        file.height = Int(UIScreen.main.bounds.height)
        file.cacheUrl = file.cacheURLConstructor()
        file.cached = file.checkDoesCacheExist()
        file.cached = false
        file.cacheUrl = nil
        _ = file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
            self.asset.loading = false
            if error == nil {
                if let resim = UIImage(data: data!) {
                    self.asset.cacheState = "full"
                    self.asset.coverImage = resim
                    self.imageViewHero.image = self.asset.coverImage
                }
            }
        })
    }
    
}
