//
//  SelectMediaViewController+UICollectionViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension SelectMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryMedia.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellContributeMedia", for: indexPath) as! ContributeMediaCollectionViewCell
        let asset = galleryMedia[indexPath.row]
        cell.asset = asset
        cell.isMediaSelected = selectedMedia.contains(asset)
        cell.prepareCell()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width-15)/2
        return CGSize(width: width, height: width*13/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = galleryMedia[indexPath.row]
        if selectedMedia.contains(asset) {
            selectedMedia.remove(at: selectedMedia.index(of: asset)!)
        } else {
            selectedMedia.append(asset)
        }
        collectionView.reloadItems(at: collectionView.indexPathsForVisibleItems)
        prepareGfx()
    }
}
