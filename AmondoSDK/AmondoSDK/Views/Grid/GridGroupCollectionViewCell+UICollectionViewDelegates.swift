//
//  GridGroupCollectionViewCell+UICollectionViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension GridGroupCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ContentDynamicLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let events = gridItem.content as! [AMDAsset]
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let events = gridItem.content as! [AMDAsset]
        
        return ImprintGridUtil.cellForAsset(item: events[indexPath.row], collectionView: collectionView, indexPath: indexPath, parent: self, downloadQueue: &activeDownloads, gridStyle: gridStyle)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let events = gridItem.content as! [AMDAsset]
        if delegate != nil {
            delegate?.gridGroupCellOpen(tile: events[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let events = gridItem.content as! [AMDAsset]
        let asset = events[indexPath.row]
        if asset.type == "video" {
            if let cellVideo = cell as? VideoCollectionViewCell {
                cellVideo.avPlayer?.play()
            }
        }
    }
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        let assets =  gridItem.content as! [AMDAsset]
        let asset = assets[indexPath.row]
        
        let width = UIScreen.main.bounds.width-8
        let heightSquare = width/2
        let heightPortrait = width/2+30
        
        let w = heightSquare;
        let h = asset.orientation == .portrait ? heightPortrait : heightSquare
        return CGSize(width: w, height: h)
    }
    
}
