//
//  ItemVideoVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/20/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ItemVideoViewController {
    
    func prepareGestures() {
        let tapGestureClose = UITapGestureRecognizer(target: self, action: #selector(ItemVideoViewController.closeAnimation))
        viewPlayerWrapper.addGestureRecognizer(tapGestureClose)
        
        let gesturePanPlayer = UIPanGestureRecognizer(target: self, action: #selector(viewPannedPlayer(gesture:)))
        gesturePanPlayer.delegate = self
        viewPlayerWrapper.addGestureRecognizer(gesturePanPlayer)
        
        let gesturePanInfo = UIPanGestureRecognizer(target: self, action: #selector(viewPannedInfo(gesture:)))
        gesturePanInfo.delegate = self
        viewInfo.addGestureRecognizer(gesturePanInfo)
    }
    
    func prepareUI() {        
        labelUsername.font = Fonts.sfSemiBold(size: 14)
        labelInfo.font = Fonts.sfSemiBold(size: 10)
        labelDescription.font = Fonts.sfRegular(size: 16)
        buttonOpen.titleLabel?.font = Fonts.sfSemiBold(size: 15)
        imageViewUserAvatar.layer.cornerRadius = 24
        imageViewUserAvatar.layer.masksToBounds = true
        
        buttonOpen.layer.cornerRadius = 8
        buttonOpen.layer.borderWidth = 1
        buttonOpen.layer.borderColor = Colors.white.cgColor
        
        addBlurViews()
        
        if image != nil {
            aspectRatio = image!.size.height/image!.size.width
        }
        if avPlayer != nil && avPlayer.currentItem != nil {
            aspectRatio = avPlayer.currentItem!.presentationSize.height/avPlayer.currentItem!.presentationSize.width
            let height = UIScreen.main.bounds.width*aspectRatio
            layoutConstraintVideoWrapperHeight.constant = height >= UIScreen.main.bounds.height/2 ?UIScreen.main.bounds.height/2 : height
            view.layoutIfNeeded()
        }
        
    }
    
    func prepareData() {
        labelUsername.text = asset.video!.username
        labelInfo.text = "\(asset.video!.source!.uppercased()) • \((asset.date).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none).uppercased())"
        labelDescription.text = asset.video?.description
        view.layoutIfNeeded()

        let source = asset.aobject?["source"] as? String
        let title = source?.lowercased() == "amondo" ? "Open" : "Open in " + source!
        buttonOpen.setTitle(title , for: .normal)
        let file = AMDFile(file: asset.aobject!["avatar"] as! Dictionary<String, Any>, ftype: "photo")
        file.getDataInBackground { (error:Error?, data:Data?, cached:Bool) in
            if error == nil {
                let img = UIImage(data: data!)
                if let imageViewAvatar = self.imageViewUserAvatar {
                    imageViewAvatar.image = img
                }
                
            }
        }
    }
    
}
