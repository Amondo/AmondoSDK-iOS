//
//  GridScrollerCollectionViewCell+UICollectionViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension GridScrollerCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let articles = gridItem.content as! [AMDAsset]
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let articles = gridItem.content as! [AMDAsset]
        
        return ImprintGridUtil.cellForAsset(item: articles[indexPath.row], collectionView: collectionView, indexPath: indexPath, parent: self, downloadQueue: &activeDownloads!, gridStyle: gridStyle)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let events = gridItem.content as! [AMDAsset]
        if delegate != nil {
            delegate?.gridScrollerCellOpen(tile: events[indexPath.row])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let articles = gridItem.content as! [AMDAsset]
        let article = articles[indexPath.row]
        let width = UIScreen.main.bounds.width-30
        
        if article.orientation == .square {
            return CGSize(width: width, height: width)
        } else if article.orientation == .landscape {
            return CGSize(width: width*6/5, height: width)
        } else {
            return CGSize(width: width*4/5, height: width)
        }
    }
    
}

