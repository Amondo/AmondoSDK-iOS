//
//  ItemArticleVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


extension ItemArticleViewController {
    
    func prepareForInitialAnimtion(){
        imageViewCover.alpha = 0
        transitionImageView.alpha = 1
        imageViewCover.layer.masksToBounds = true
        buttonOpen.alpha = 0
    }
    
    func initialAnimation(){
        self.transitionImageView.alpha = 1
        var yPosition = (self.view.bounds.height - self.view.bounds.width)/2;
        if UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688 {
            yPosition = yPosition+4
        } else {
            yPosition = yPosition+10
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.transitionImageView.frame.origin = CGPoint(x: 0, y: yPosition)
            self.transitionImageView.frame.size = CGSize(width: self.view.bounds.width,height: self.view.bounds.width)
        }, completion: { (b:Bool) in
            self.imageViewCover.alpha = 1
            self.transitionImageView.alpha = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.viewBackground.alpha = 1
                self.buttonOpen.alpha = 1
            })
        })
    }
    
    func closeAnimation(){
        let parent = self.parent as! ImprintViewController
        parent.view.isUserInteractionEnabled = false
        parent.showCells()
        let yPosition = (self.view.bounds.height - self.view.bounds.width)/2;
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height != 2436 {
            
        }
        viewBackground.alpha = 0
        buttonOpen.alpha = 0
        imageViewCover.alpha = 0
        transitionImageView.alpha = 1
        transitionImageView.frame.origin.y = CGFloat(yPosition)
        UIView.animate(withDuration: 0.4, animations: {
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
    
    @IBAction func openArticle() {
        let browserVC = BrowserViewController.instance()
        if let urlString = self.asset.aobject!["url"] as? String {
            browserVC.url = URL(string: urlString)
            present(browserVC, animated: true, completion: nil)
        }
    }
    
    func displayImage() {
        let item = asset!
        if item.coverImage != nil {
            self.imageViewCover.image = item.coverImage
            return
        }
        
        if item.cacheState == "small" {
            if item.loading == false {
                item.loading = true
                let file = AMDFile(file: item.aobject!["file"] as! Dictionary<String, Any>, ftype: "photo")
                
                file.width = Int(imageViewCover.bounds.width)
                file.height = Int(imageViewCover.bounds.height)
                file.cacheUrl = file.cacheURLConstructor()
                file.cached = file.checkDoesCacheExist()
                
                let r = file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
                    item.loading = false
                    
                    if error == nil {
                        
                        if let resim = UIImage(data: data!) {
                            item.cacheState = "full"
                            item.coverImage = resim
                            self.imageViewCover.image = item.coverImage
                        }
                    }
                })
            }
        }
    }
    
}
