//
//  TileDetailsVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/27/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

extension TileDetailsViewController {
    
    func prepareUI() {
        let fileObject = asset.aobject?["file"] as? [String:Any]
        if (fileObject!["original_url"] as? String) != nil {
            
        } else {
            
        }
        self.imageViewHero.contentMode = .scaleAspectFill
        
        labelUsername.font = gridStyle.tileUsernameFont
        labelInfo.font = gridStyle.tileInfoFont
        labelDescription.font = gridStyle.tileDescriptionFont
        buttonOpenUrl.titleLabel?.font = gridStyle.buttonActionFont
        viewVolumeWrapper.layer.cornerRadius = 14.0
        viewVolumeWrapper.clipsToBounds = true
        viewVolumeWrapper.layer.masksToBounds = true
        let screenWidth = UIScreen.main.bounds.width
        if asset.orientation == .portrait && !asset.isTwitterStatus {
            layoutConstraintMediaWrapperHeight.constant = screenWidth*154/120
            aspectRatio = 154/120
        } else {
            
            if asset.orientation == .square {
                layoutConstraintMediaWrapperHeight.constant = screenWidth
                aspectRatio = 1
            } else if asset.orientation == .landscape {
                layoutConstraintMediaWrapperHeight.constant = screenWidth*5/6
                aspectRatio = 5/6
            } else {
                layoutConstraintMediaWrapperHeight.constant = screenWidth*5/4
                aspectRatio = 5/4
            }
        }
        
        buttonOpenUrl.layer.cornerRadius = 8
        buttonOpenUrl.layer.borderColor = Colors.white.cgColor
        buttonOpenUrl.layer.borderWidth = 1
        
        layoutConstraintContentTop.constant = heightHeader
        
        view.layoutIfNeeded()
    }
    
    func prepareGestures() {
        gestureSwipeAsset = UISwipeGestureRecognizer(target: self, action: #selector(viewAssetSwipeDown(gesture:)))
        gestureSwipeAsset.direction = .down
        gestureSwipeAsset.delegate = self
        viewAssetWrapper.addGestureRecognizer(gestureSwipeAsset)
        
        gestureSwipeInfoUp = UISwipeGestureRecognizer(target: self, action: #selector(descriptionSwipeUp(gesture:)))
        gestureSwipeInfoUp.direction = .up
        gestureSwipeInfoUp.delegate = self
        labelDescription.addGestureRecognizer(gestureSwipeInfoUp)
        
        gestureSwipeInfoDown = UISwipeGestureRecognizer(target: self, action: #selector(descriptionSwipeDown(gesture:)))
        gestureSwipeInfoDown.direction = .down
        gestureSwipeInfoDown.delegate = self
        labelDescription.addGestureRecognizer(gestureSwipeInfoDown)
    }
    
    func prepareData() {
        layoutConstraintMediaInfoHeight.constant = 71
        view.layoutIfNeeded()
        viewOpenWrapper.isHidden = true
        viewInfo.isHidden = false
        labelDescription.text = ""
        viewVolumeWrapper.isHidden = true
        buttonVolume.isSelected = false
        
        if let instagram = asset.instagram {
            labelUsername.text = instagram.username
            labelInfo.text = "\(instagram.source!.uppercased()) • \((asset.date).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none).uppercased())"
            labelDescription.text = instagram.description
        }
        
        if let video = asset.video {
            labelUsername.text = video.username
            labelInfo.text = "\(video.source!.uppercased()) • \((asset.date).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none).uppercased())"
            labelDescription.text = video.description
        }
        
        if asset.type == "url" {
            layoutConstraintMediaInfoHeight.constant = 0
            view.layoutIfNeeded()
            
            viewOpenWrapper.isHidden = false
            viewInfo.isHidden = true
            let source = asset.aobject?["source"] as? String
            let title = source?.lowercased() == "amondo" ? "Open" : "Open in " + source!
            buttonOpenUrl.setTitle(title , for: .normal)
        } else {
            if !Optional.isNil(asset.aobject!["avatar"]) {
                let file = AMDFile(file: asset.aobject!["avatar"] as! Dictionary<String, Any>, ftype: "photo")
                file.getDataInBackground { (error:Error?, data:Data?, cached:Bool) in
                    if error == nil {
                        let img = UIImage(data: data!)
                        self.imageViewAvatar.image = img
                    }
                }
            }
        }
        
        if image != nil {
            imageViewHero.image = image
        } else {
            fetchHeroImage(tileAsset: asset)
            
            let gridTemplate = imprint.grid
            let nextAsset = gridTemplate?.nextAsset(from: asset)
            if nextAsset != nil {
                fetchHeroImage(tileAsset: nextAsset!)
            }
            let previousAsset = gridTemplate?.nextAsset(from: asset)
            if previousAsset != nil {
                fetchHeroImage(tileAsset: previousAsset!)
            }
        }
    }
}
