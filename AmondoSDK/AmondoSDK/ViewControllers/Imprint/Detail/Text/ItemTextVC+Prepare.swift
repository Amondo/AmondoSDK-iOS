//
//  ItemTextVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/7/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ItemTextViewController {
    
    func prepareGestures() {
        let imTap = UITapGestureRecognizer(target: self, action: #selector(ItemTextViewController.closeAnimation))
        self.view.addGestureRecognizer(imTap)
        
        let imTap2 = UITapGestureRecognizer(target: self, action: #selector(ItemTextViewController.closeAnimation))
        transitionImageView.addGestureRecognizer(imTap2)
        
        let gesturePan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(gesture:)))
        gesturePan.delegate = self
        self.view.addGestureRecognizer(gesturePan)
    }
    
    func prepareGfx() {
        imageViewText.layer.cornerRadius = 10
        imageViewUserAvatar.layer.cornerRadius = 32
        imageViewUserAvatar.layer.masksToBounds = true
        
        labelUsername.font = Fonts.sfSemiBold(size: 14)
        labelInfo.font = Fonts.sfSemiBold(size: 10)
        
        if image != nil {
            let aspectRatio = image!.size.height/image!.size.width
            layoutConstraintImageViewHeight.constant = self.view.bounds.width*aspectRatio
            self.view.layoutIfNeeded()
        }
    }
    
    func prepareData() {
        labelInfo.text = "\(asset.instagram!.source!.uppercased()) • \((asset.date).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none).uppercased())"
        labelUsername.text = asset.instagram?.username
        
        if !Optional.isNil(asset.aobject!["avatar"]) {
            let file = AMDFile(file: asset.aobject!["avatar"] as! Dictionary<String, Any>, ftype: "photo")
            file.getDataInBackground { (error:Error?, data:Data?, cached:Bool) in
                if error == nil {
                    let img = UIImage(data: data!)
                    self.imageViewUserAvatar.image = img
                }
            }
        }
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.image = self.asset.coverImage
                self.imageViewText.image = self.image
                self.transitionImageView.image = self.image
            }
        }
        
        transitionImageView.frame = initialFrame
        transitionImageView.contentMode = .scaleAspectFill
        transitionImageView.image = image
        transitionImageView.clipsToBounds = true
        transitionImageView.isUserInteractionEnabled = true
        self.view.addSubview(transitionImageView)
    }
}
