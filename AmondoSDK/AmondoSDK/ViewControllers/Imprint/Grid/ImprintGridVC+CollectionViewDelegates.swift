//
//  ImprintGridVC+CollectionViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension ImprintGridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gridStyle.presentSplash ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itemsSection = gridStyle.presentSplash ? 1 : 0
        if section == itemsSection  && self.imprint.grid != nil {
            return self.imprint.grid!.items.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let gridItem = self.imprint.grid!.items[indexPath.row]
        
        if gridItem.type == .scroller {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGridScroller", for: indexPath) as! GridScrollerCollectionViewCell
            cell.gridItem = gridItem
            cell.delegate = self
            cell.activeDownloads = activeDownloads
            cell.prepareCell()
            
            return cell
        } else if gridItem.type  == .group {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGridGroup", for: indexPath) as! GridGroupCollectionViewCell
            cell.gridItem = gridItem
            cell.delegate = self
            cell.activeDownloads = activeDownloads
            cell.gridStyle = gridStyle
            cell.prepareCell()
            
            return cell
        }
        
        return ImprintGridUtil.cellForAsset(item: gridItem.content as! AMDAsset, collectionView: collectionView, indexPath: indexPath, parent: view, downloadQueue: &activeDownloads, gridStyle: gridStyle)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if gridStyle.presentSplash  {
            if section == 0 {
                return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.bounds.size.height-heightHeader)
            } else if section == 1 {
                return CGSize(width: UIScreen.main.bounds.size.width, height: heightHeader)
            }
            
            return CGSize(width: 0, height: 0)
        }
        
        if section == 0 {
            return CGSize(width: UIScreen.main.bounds.size.width, height: heightHeader)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridItem = self.imprint.grid!.items[indexPath.row]
        let width = gridItem.type == .scroller || gridItem.type  == .group ? UIScreen.main.bounds.width : gridItem.width!
        
        return CGSize(width: width, height: gridItem.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gridItem = self.imprint.grid!.items[indexPath.row]
        
        if gridItem.type == .scroller {
            
        } else if gridItem.type  == .group {
            
        } else {
            //regular cell, should  open
            openTile(tile: gridItem.content as! AMDAsset)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let gridItem = self.imprint.grid!.items[indexPath.row]
        
        if gridItem.type == .scroller {
            
        } else if gridItem.type  == .group {
            
        } else {
            let asset = gridItem.content as! AMDAsset
            if asset.type == "video" {
                if let cellVideo = cell as? VideoCollectionViewCell {
                    cellVideo.avPlayer?.play()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if gridStyle.presentSplash && indexPath.section == 0 {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableViewGridSplash", for: indexPath) as! GridSplashReusableView
            reusableView.imprint = imprint
            reusableView.prepareGfx()
            
            return reusableView
        } else {
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusableViewGridHeader", for: indexPath) as! GridHeaderReusableView
            reusableView.imprint = imprint
            reusableView.gridStyle = gridStyle
            reusableView.prepareReusableView()
            headerGrid = reusableView
            if !gridStyle.presentSplash  {
                headerGrid?.hideHeroImage()
            }
            return reusableView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if !gridStyle.presentSplash {
            return
        }
        if headerGrid != nil {
            headerGrid?.hideHeroImage()
            showActionButtons()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if !gridStyle.presentSplash {
            return
        }
        if headerGrid != nil {
            headerGrid?.showHeroImage()
            hideActionButtons()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionViewImprint && headerGrid != nil {
            if heightTotal != nil {
                let trailingConstraint = UIScreen.main.bounds.width-(collectionViewImprint.contentOffset.y/heightTotal*UIScreen.main.bounds.width)
                headerGrid?.updateProgress(progress: trailingConstraint)
            }
            if gridStyle.presentSplash {
                let y = scrollView.contentOffset.y
                if y > UIScreen.main.bounds.height/2 {
                    let screenHeight = UIScreen.main.bounds.height/2
                    let opacity = -(screenHeight-(y+heightHeader))/screenHeight
                    headerGrid?.animateTitle(opacity: 1-opacity)
                } else {
                    headerGrid?.animateTitle(opacity: 1)
                }
            }
        }
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == collectionViewImprint && headerGrid != nil {
            let y = scrollView.contentOffset.y
            
            if y >= heightTotal || y+4 >= heightTotal || y+39 == heightTotal || y+43 >= heightTotal {
                self.hideActionButtons()
                showFinito(animated: true)
            }
        }
    }
    
}
