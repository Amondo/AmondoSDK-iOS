//
//  ImprintViewController+UICollectionViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 9/7/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension ImprintViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView != self.collectionViewAssets{return}
        
        isDragging = true
        let currentSection = Int(scrollView.contentOffset.y/self.view.bounds.height)
        if currentSection >= sections.count {
            return
        }
        
        let sec = sections[currentSection]
        for ind in sec {
            ind.avPlayer?.pause()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != self.collectionViewAssets{ return }
        let newSection = Int(scrollView.contentOffset.y/self.view.bounds.height)
        
        if self.currentSection != newSection {
            if self.currentSection < sections.count {
                endTimingAndTrackSection(self.currentSection, nextSection: newSection)
            }
        }
        
        self.currentSection = newSection
        if newSection >= sections.count {
            return
        }

        self.currentSection = newSection
        pageControlAssets.currentPage = newSection
        let sec = sections[newSection]
        
        for ind in sec {
            ind.avPlayer?.play()
            ind.avPlayer?.isMuted = true
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isDragging = false
        var beyondTop = false
        if scrollView != self.collectionViewAssets{return}
        let y = scrollView.contentOffset.y
        
        if scrollScale == 0 && y > 0 {
            let heightSections = CGFloat(sections.count-1)*self.view.bounds.height
            if currentSection == sections.count-1 && (y == heightSections || y-34 == heightSections) {
                let heightSections = CGFloat(self.sections.count-1)*self.view.bounds.height
                self.collectionViewAssets.contentOffset.y = UIDevice().userInterfaceIdiom == .phone && ( UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688 ) ? heightSections : heightSections
                self.hideActionButtons()
                showFinito(animated: true)
            }
            return;
        }
        if y > self.view.bounds.height/2 {
            beyondTop = true
        }
        
        if scrollView.contentOffset.y <= -20 || scrollView.contentOffset.y == 0 {
            closedImprint()
            self.view.layer.cornerRadius = 12
        }

        if scrollScale > 200 {
            scrollScale = 0
            
            if beyondTop {
                scrollView.contentOffset.y = CGFloat(sections.count)*self.view.bounds.height
            } else {
                scrollView.contentOffset.y = 0
            }
            
            closedImprint()
            self.view.layer.cornerRadius = 12
        } else {
            scrollScale = 0
            
            if beyondTop {
                scrollView.contentOffset.y = CGFloat(sections.count)*self.view.bounds.height
            } else {
                scrollView.contentOffset.y = 0
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                
                if self.currentSection == 0 {
                    self.pageControlAssets.alpha = 1
                    self.hideActionButtons()
                } else if self.currentSection >= self.sections.count {
                    self.pageControlAssets.alpha = 0
                    self.hideActionButtons()
                } else {
                    self.pageControlAssets.alpha = 1
                    self.showActionButtons()
                }
                
                self.view.center.y = UIScreen.main.bounds.height/2
                self.backView.alpha = 1
                self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.view.layer.cornerRadius = 0
            })
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView != self.collectionViewAssets{ return }
        if IMPRINTVC == nil { return }
        
        if scrollView.contentOffset.y > CGFloat(sections.count-1)*self.view.bounds.height {
            UIView.animate(withDuration: 0.3, animations: {
                self.pageControlAssets.alpha = 0
                //self.hideActionButtons()
            })
        } else if scrollView.contentOffset.y > 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.pageControlAssets.alpha = 1
            })
            if scrollView.contentOffset.y > self.view.bounds.height/4 {
                UIView.animate(withDuration: 0.3, animations: {
                    self.showActionButtons()
                })
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
                    self.showTutorial(step: .openTile)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.hideActionButtons()
                })
            }
        }

        if isDragging == false {
            return;
        }
        
        var y = scrollView.contentOffset.y
        var beyondTop = false
        if scrollView.contentOffset.y >= CGFloat(sections.count-1)*self.view.bounds.height {
            let heightSections = CGFloat(self.sections.count-1)*self.view.bounds.height
            collectionViewAssets.contentOffset.y = heightSections
            if scrollView.contentOffset.y >= CGFloat(sections.count)*self.view.bounds.height {
                beyondTop = true
                y = -(scrollView.contentOffset.y - CGFloat(sections.count)*self.view.bounds.height)
            }
        }
        
        if isDragging && scrollScale > 0{
            if y > self.view.bounds.height/2 {
                y = -(scrollView.contentOffset.y - CGFloat(sections.count)*self.view.bounds.height)
                beyondTop = true
            }
        }
        
        if isHiddenAllowed == false {
            return;
        }
        
        if scrollScale == 0 && y > 0 {
            return;
        }
        
        if scrollScale < 0 {
            scrollScale = 0
            return
        }
        
        if y > 0 && scrollScale != 0 {
            scrollScale -= y
            
            if beyondTop {
                scrollView.contentOffset.y = CGFloat(sections.count)*self.view.bounds.height
            } else {
                scrollView.contentOffset.y = 0
            }
        } else {
            if y < 0 {
                scrollScale -= y
                
                if beyondTop {
                    scrollView.contentOffset.y = CGFloat(sections.count)*self.view.bounds.height
                } else {
                    scrollView.contentOffset.y = 0
                }
            } else if y > 0 && scrollScale > 1 {
                if (scrollScale + y) < 0 {
                    scrollScale -= y
                    
                    if beyondTop {
                        scrollView.contentOffset.y = CGFloat(sections.count)*self.view.bounds.height
                    } else {
                        scrollView.contentOffset.y = 0
                    }
                } else {
                    scrollScale = 0
                    
                    if beyondTop {
                        scrollView.contentOffset.y = CGFloat(sections.count)*self.view.bounds.height
                    } else {
                        scrollView.contentOffset.y = 0
                    }
                }
            }
        }
        
        var scale = scrollScale/200
        if scale > 1 {
            scale = 1
        }
        let max: CGFloat = 0.15
        self.backView.alpha = 1-scale*max
        self.view.transform = CGAffineTransform(scaleX: 1-scale*max, y: 1-scale*max)
        
        if beyondTop {
            self.view.center.y = UIScreen.main.bounds.height/2-scrollScale/30
        } else {
            self.view.center.y = UIScreen.main.bounds.height/2+scrollScale/30
        }
        
        let cr = scale*12
        if currentSection == 0 {
            self.pageControlAssets.alpha = 1-scale
            self.buttonMenu.alpha = 0
            self.buttonContribute.alpha = 0
        } else if currentSection >= sections.count {
            self.pageControlAssets.alpha = 0
            self.buttonMenu.alpha = 0
            let progress = Float(self.currentSection / sections.count)
            logOpen(progress: progress)
            
        } else {
            self.pageControlAssets.alpha = 1 - scale
            self.buttonMenu.alpha = 1 - scale
            self.buttonContribute.alpha = 1 - scale
        }
        self.view.layer.cornerRadius = cr
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let x = (self.view.bounds.width-16-20)/3
        return CGSize(width: x, height: x)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellViews.count != 0 {
            return cellViews[indexPath.section][indexPath.row]
        }
        
        let item = sections[indexPath.section][indexPath.item]
        
        if item.type == "photo" || item.type == "status" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGridImage", for: indexPath) as! GridImageCollectionViewCell
            cell.item = item
            cell.prepareCell(indexPath: indexPath)
            
            return cell
        } else if item.type == "music" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            
            let r = cell.displayImageWithDownload(item: item, indexPath: indexPath, vcView: self.view, completion: { (firstLoad, success) in
                if firstLoad && success {
                    self.showLoadedImageOrVideo(asset:item)
                }
            })
            
            if r != nil {
                activeDownloads.append(r!)
            }
            
            cell.alpha = 1
            
            return cell
        } else if item.type == "url" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGridArticle", for: indexPath) as! GridArticleCollectionViewCell
            
            let r = cell.displayImageWithDownload(item: item, indexPath: indexPath, vcView: self.view, completion: { (firstLoad, success) in
                if firstLoad && success {
                    self.showLoadedImageOrVideo(asset:item)
                }
            })
            
            if r != nil {
                activeDownloads.append(r!)
            }
        
            cell.alpha = 1
            
            return cell
        } else if item.type == "video" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvideo", for: indexPath) as! CuratedVideoCollectionViewCell
            cell.indexPath = indexPath
            cell.imageViewFrame.image = item.coverImage
            cell.blur.alpha = 1
            
            if item.avPlayer == nil {
                cell.clearAvPlayer()
                if item.loading == false {
                    item.loading = true
                    let file = AMDFile(file: item.aobject!["file"] as! Dictionary<String,Any>, ftype: "video")
                    file.width = Int(300)
                    file.height = Int(300)
                    file.quality = 80
                    
                    file.cacheUrl = file.cacheURLConstructor()
                    file.cached = file.checkDoesCacheExist()
                    
                    let r = file.getDataInBackground(completion: { (error:Error?, data:Data?, cached:Bool) in
                        item.loading = false
                        if error == nil {
                            file.type = AMDFileType.video
                            file.cacheUrl = file.cacheURLConstructor()
                            file.cached = file.checkDoesCacheExist()
                            item.dataURL = file.cacheUrl
                            
                            item.avPlayer = file.dataToVideo_AVPlayer()
                            item.cacheState = "full"

                            if cell.indexPath == indexPath {
                                cell.avPlayer = item.avPlayer!
                                cell.playAvPlayer(item.avPlayer!)
                                if self.currentSection == indexPath.section {
                                    cell.avPlayer.play()
                                } else {
                                    cell.avPlayer.pause()
                                }
                                UIView.animate(withDuration: 0.3, animations: {
                                    cell.blur.alpha = 0
                                })
                            }
                            self.showLoadedImageOrVideo(asset: item)
                        }
                    })
                    if r != nil {
                        activeDownloads.append(r!)
                    }
                }
            } else {
                cell.avPlayer = item.avPlayer!
                cell.playAvPlayer(item.avPlayer!)
                if self.currentSection == indexPath.section {
                    cell.avPlayer.play()
                } else {
                    cell.avPlayer.pause()
                }
                UIView.animate(withDuration: 0.3, animations: {
                    cell.blur.alpha = 0
                })
            }
            return cell
        }
        
        if item.type == "TopTile" {
            let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEvent", for: indexPath) as! EventCollectionViewCell
            gridCell.prepareCell(item: currentImprint, indexPath: indexPath)
            self.loadingItems ? gridCell.startLoader() : gridCell.stopLoader()
            gridCell.prepareSafeArea()

            return gridCell
        }
        
        if item.asset?.mediaType  == .image {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            let option = PHImageRequestOptions()
            
            let csize = CGSize(width: cell.frame.size.width*2, height: cell.frame.size.height*2)
            if phmanager == nil {
                phmanager = PHImageManager.default()
            }
            phmanager?.requestImage(for: item.asset!, targetSize: csize, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                if result != nil {
                    cell.imageView.image = result!
                    item.coverImage=result!
                }
            })
            
            cell.logoView.image = nil
            cell.alpha = 1
            cell.blur.alpha = 0
            
            return cell
        }
        
        if item.asset?.mediaType  == .video {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvideo", for: indexPath) as! CuratedVideoCollectionViewCell
            cell.playVideoFile(nil, avPlayerAMD: item.avPlayer, url: nil)
            cell.blur.alpha = 0
    
            return cell
        }
        
        if item.asset?.mediaType  == .video {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvideo", for: indexPath) as! CuratedVideoCollectionViewCell
            cell.playVideoFile(nil, avPlayerAMD: item.avPlayer, url: nil)
            cell.blur.alpha = 0
            
            return cell
        }
        
        if item.asset == nil {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unsupported", for: indexPath)
            for v in cell.contentView.subviews {
                if v.isKind(of: UILabel.self) {
                    (v as! UILabel).text = "unsupported\n\(item.objectId())"
                }
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            (self.collectionViewAssets.collectionViewLayout as! ImprintLayout).beGone = true
            closedImprint()
            return;
        }
        hideActionButtons()
        let asset = sections[indexPath.section][indexPath.item]
        var source:String = "device"
        if asset.aobject?["source"] != nil {
            source = asset.aobject!["source"] as! String
        }
        
        if source != "device" {
            if asset.cacheState != "full" {
                let cell = collectionViewAssets.cellForItem(at: indexPath)
                let label = UILabel(frame: cell!.bounds)
                label.textAlignment = .center
                label.textColor = UIColor.white
                label.text = "Corrupt\n \(asset.objectId())"
                label.alpha = 0
                label.numberOfLines = 2
                cell!.contentView.addSubview(label)
                UIView.animate(withDuration: 0.5, animations: {
                    label.alpha = 1
                    UIView.animate(withDuration: 0.3, animations: {
                        label.alpha = 0
                    }, completion: { (b) in
                        label.removeFromSuperview()
                    })
                })
            }
        }
        showDetailViewForAsset(asset, atIndex: indexPath)
    }
    
}
