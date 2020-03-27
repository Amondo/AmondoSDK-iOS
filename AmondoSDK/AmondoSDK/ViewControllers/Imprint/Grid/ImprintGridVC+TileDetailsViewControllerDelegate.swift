//
//  ImprintGridVC+TileDetailsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension ImprintGridViewController: TileDetailsViewControllerDelegate {
    
    func tileDetailsClose() {
        let audioSession = AVAudioSession.sharedInstance()
        try?audioSession.setCategory(.playback, options: .mixWithOthers)
        try?audioSession.setActive(true)
        
        dismiss(animated: true) {
            
        }
    }
    
    
    func tileDetailsPrevious(tileDetailsVC: TileDetailsViewController, asset:  AMDAsset) {
        let gridTemplate = imprint.grid
        let previousAsset = gridTemplate?.previousAsset(from: asset)
        
        if previousAsset != nil {
            tileDetailsVC.asset = previousAsset
            tileDetailsVC.image = nil
            tileDetailsVC.refresh()
            let assetsGrid = gridTemplate?.items.last?.content as! [AMDAsset]
            let assetInGrid = assetsGrid.filter{$0.objectId() == asset.objectId()}.first
            
            if (assetInGrid != nil) && (assetInGrid!.offsetY != nil) {
                let yOffset = UIScreen.main.bounds.height+assetInGrid!.offsetY
                if yOffset < heightTotal && yOffset < self.collectionViewImprint.contentOffset.y  {
                    self.collectionViewImprint.contentOffset = CGPoint(x: 0, y: yOffset)
                }
            }
        } else {
            UIImpactFeedbackGenerator().impactOccurred()
            self.collectionViewImprint.contentOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height-heightHeader)
            dismiss(animated: true) {
                
            }
        }
    }
    
    func tileDetailsNext(tileDetailsVC: TileDetailsViewController, asset:  AMDAsset) {
        let gridTemplate = imprint.grid
        let nextAsset = gridTemplate?.nextAsset(from: asset)
        
        if nextAsset != nil {
            tileDetailsVC.asset = nextAsset
            tileDetailsVC.image = nil
            tileDetailsVC.refresh()
            let assetsGrid = gridTemplate?.items.last?.content as! [AMDAsset]
            let assetInGrid = assetsGrid.filter{$0.objectId() == asset.objectId()}.first
            
            if (assetInGrid != nil) && (assetInGrid!.offsetY != nil) {
                let yOffset = UIScreen.main.bounds.height+assetInGrid!.offsetY
                if yOffset < heightTotal && yOffset > self.collectionViewImprint.contentOffset.y {
                    self.collectionViewImprint.contentOffset = CGPoint(x: 0, y: yOffset)
                }
            }
        } else {
            var heightTotal = UIScreen.main.bounds.height
            gridTemplate?.items.forEach({ (item) in
                heightTotal += item.height
            })
            UIImpactFeedbackGenerator().impactOccurred()
            self.collectionViewImprint.contentOffset = CGPoint(x: 0, y: heightTotal-UIScreen.main.bounds.height-heightHeader-254)
            dismiss(animated: true) {
                
            }
        }
    }
    
}
