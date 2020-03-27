//
//  ImprintViewController+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 7/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AVKit

extension ImprintViewController {
    
    func showPageControl() {
        self.view.bringSubviewToFront(self.pageControlAssets)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControlAssets.alpha = 1
        })
    }
    
    func showImprintActions() {
        self.viewPageControllerWrapper.isHidden = true
        self.view.bringSubviewToFront(self.pageControlAssets)
        self.view.bringSubviewToFront(self.buttonMenu)
        self.view.bringSubviewToFront(self.buttonContribute)
        self.view.bringSubviewToFront(self.visualEffectViewBlurMenu)
        self.view.bringSubviewToFront(self.visualEffectViewBlurContribute)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControlAssets.alpha = 1
            self.showActionButtons()
        })
        
        if shouldShowTutorialContribute {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
                self.showTutorial(step: .contribute)
                self.shouldShowTutorialContribute = false
                UserDefaultsManager.shouldSkipTutorial = true
            })
        }
    }
    
    func playVideos() {
        var sIndex = 0
        for sec in sections {
            for ind in sec {
                if currentSection == sIndex {
                    ind.avPlayer?.play()
                } else {
                    ind.avPlayer?.pause()
                }
                
            }
            sIndex += 1
        }
        
        return; //TODO CHECK!
        for cell in collectionViewAssets.visibleCells {
            if cell.isKind(of: GridVideoCollectionViewCell.self) {
                let cell = cell as! GridVideoCollectionViewCell
                cell.startPlaying()
            }
        }
    }
    
    func closedImprint() {
        
        for req in activeDownloads {
            req.cancel()
        }
        
        if currentImprint.items.count == 0 {
            return;
        }
        
        var types = [[String]]()
        var ids = [[String]]()
        var sources = [[String]]()
        var section = 0
        
        for el in sections {
            var index = 0
            for item in el {
                item.loading = false
                if index == 0 {
                    types.append([item.type])
                    if item.aobject != nil {
                        ids.append([item.objectId()])
                        sources.append([item.aobject!["source"] as! String])
                    } else {
                        ids.append([item.type])
                        sources.append([item.type])
                    }
                } else {
                    types[section].append(item.type)
                    if item.aobject != nil {
                        ids[section].append(item.objectId())
                        sources[section].append(item.aobject!["source"] as! String)
                    } else {
                        ids[section].append(item.type)
                        sources[section].append(item.type)
                    }
                }
                index = index+1
            }
            section = section+1
        }
        UploadManager.instance.delegate = nil
        self.currentImprint.closeImprint {
            
        }
    }
    
    func nextSection() -> Int {
        switch self.navigationDirection! {
        case .Down:
            return self.currentSection - 1
        case .Up:
            return self.currentSection + 1
        default:
            return 0
        }
    }
    
    func resetLayout() {
        currentSection = 0
        self.transitionLayout = nil
        self.navigationDirection = nil
        self.transitionInProgress = false
        self.pageControlAssets.currentPage = 0
        self.pageControlAssets.numberOfPages = sections.count
        self.gestInProcess = false
        self.swipeInProcess = false
        collectionViewAssets.setContentOffset(CGPoint(x: 0,y: 0), animated: true)
    }
    
    func showLoadedImageOrVideo(asset:AMDAsset) {
        if viewControllerAssetDetail != nil {
            if let dvc = viewControllerAssetDetail as? InstagramViewController {
                if asset.objectId() == dvc.asset.objectId() {
                    dvc.showAsset()
                }
            }
            
            if let dvc = viewControllerAssetDetail as? ArticleViewController {
                if asset.objectId() == dvc.asset.objectId() {
                    dvc.showAsset()
                }
            }
        }
    }
    
    func moveAlbumsSquare() {
        for var section in sections {
            var index=0
            for element in section {
                if element.type == "music"{
                    if section.count == 2 {
                        if index != 1 {
                            section=rearrange(section, fromIndex: index, toIndex: 1)
                        }
                    } else if section.count == 4 {
                        if index != 0 {
                            section=rearrange(section, fromIndex: index, toIndex: 0)
                        }
                    } else if section.count == 5 {
                        if index != 3 {
                            section=rearrange(section, fromIndex: index, toIndex: 3)
                        }
                    } else if section.count == 6 {
                        if index != 5 {
                            section=rearrange(section, fromIndex: index, toIndex: 5)
                        }
                    } else if section.count == 7 {
                        if index != 2 {
                            section=rearrange(section, fromIndex: index, toIndex: 2)
                        }
                    } else if section.count == 8 {
                        if index != 0 {
                            section=rearrange(section, fromIndex: index, toIndex: 0)
                        }
                    }
                }
                index += 1
            }
        }
    }
    
    func rearrange<T>(_ array: Array<T>, fromIndex: Int, toIndex: Int) -> Array<T>{
        var arr = array
        let element = arr.remove(at: fromIndex)
        arr.insert(element, at: toIndex)
        
        return arr
    }
    
    @objc func appDidEnterBackground() {
        endTimingAndTrackSection(self.currentSection, nextSection: self.currentSection)
    }
    
    func endTimingAndTrackSection(_ section:Int,nextSection:Int) {
        if section < sections.count && section >= 0 {
            
            var types = [String]()
            var ids = [String]()
            var sources = [String]()
            
            for el in sections[section] {
                types.append(el.type)
                if el.aobject != nil {
                    ids.append(el.objectId())
                    sources.append(el.aobject!["source"] as! String)
                } else {
                    ids.append(el.type)
                    sources.append(el.type)
                }
            }
        }
    }
    
//    func viewControllerForAsset(asset: AMDAsset, indexPath: IndexPath?) -> GenericAssetViewController? {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "genericVC") as! GenericAssetViewController
//        vc.asset = asset
//        
//        return vc
//    }
    
    func showDetailViewForAsset(_ asset:AMDAsset, atIndex:IndexPath) {
        
        //generic todo
        //        viewPageControllerWrapper.isHidden = false
        //        let vc = viewControllerForAsset(asset: asset, indexPath: atIndex)
        //        pageViewControllerTiles?.setViewControllers([vc!], direction: .forward, animated: true, completion: nil)
        //        selectedItem = sectionAssets.index(where: {$0 === asset})!
        //
        //        return
        
        let indexPath = atIndex
        let assetType = asset.type
        var objectID = assetType
        
        if asset.aobject != nil {
            objectID = asset.objectId()
        }
        
        var source:String = "device"
        
        if asset.aobject?["source"] != nil {
            source = asset.aobject!["source"] as! String
        }
        
        if asset.coverImage == nil && ((assetType != "deviceVideo") && (assetType != "video")) {
            return
        }
        
        logTileOpen(asset: asset)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
            self.showTutorial(step: .closeTile)
            self.shouldShowTutorialContribute = true
        })
        
        if assetType == "photo" || assetType == "status" {
            let cell = collectionViewAssets!.cellForItem(at: indexPath) as! GridImageCollectionViewCell
            cell.alpha = 0
            hideCells(cell)
            selectedCell = indexPath
            cell.alpha = 0
            let assetFile = asset.aobject?["file"] as! Dictionary<String, Any>
            let assetFileUrl = assetFile["original_url"] as? String
            
            if assetFileUrl == nil {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TextVC") as! ItemTextViewController
                vc.asset = asset
                vc.image = asset.coverImage
                
                vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
                vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
                addChild(vc)
                vc.view.translatesAutoresizingMaskIntoConstraints = false
                
                view.addSubview(vc.view)
                
                NSLayoutConstraint.activate([
                    vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                    vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
                vc.didMove(toParent: self)
                viewControllerAssetDetail = vc
            } else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "InstagramVC") as! InstagramViewController
                vc.asset = asset
                if let image = cell.imageViewGridItem.image {
                    vc.image = image
                }
                
                vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
                vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
                addChild(vc)
                vc.view.translatesAutoresizingMaskIntoConstraints = false
                
                view.addSubview(vc.view)
                
                NSLayoutConstraint.activate([
                    vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                    vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
                vc.didMove(toParent: self)
                viewControllerAssetDetail = vc
            }
            
        } else if assetType == "url" {
            let cell = collectionViewAssets!.cellForItem(at: indexPath) as! GridArticleCollectionViewCell
            cell.alpha = 0
            hideCells(cell)
            selectedCell = indexPath
            cell.alpha = 0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ArticleVC") as! ItemArticleViewController
            vc.asset = asset
            vc.image = cell.imageViewCover.image!
            
            vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
            vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
            addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(vc.view)
            
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
            vc.didMove(toParent: self)
            viewControllerAssetDetail = vc
        } else if assetType == "article" {
            let cell = collectionViewAssets!.cellForItem(at: indexPath) as! ImageCollectionViewCell
            cell.alpha = 0
            hideCells(cell)
            selectedCell = indexPath
            cell.alpha = 0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "ArticleVC") as! ArticleViewController
            vc.asset = asset
            vc.image = cell.imageView.image!
            
            vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
            vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
            addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(vc.view)
            
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
            vc.didMove(toParent: self)
            viewControllerAssetDetail = vc
        } else if assetType == "devicePhoto" {
            let cell = collectionViewAssets!.cellForItem(at: indexPath) as! ImageCollectionViewCell
            cell.alpha = 0
            hideCells(cell)
            selectedCell = indexPath
            cell.alpha = 0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "DeviceVC") as! DeviceViewController
            vc.asset = asset
            vc.image = cell.imageView.image!
            
            vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
            vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
            addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(vc.view)
            
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
            vc.didMove(toParent: self)
            viewControllerAssetDetail = vc
        } else if assetType == "video" {
            let cell = collectionViewAssets!.cellForItem(at: indexPath) as! CuratedVideoCollectionViewCell
            cell.alpha = 0
            hideCells(cell)
            selectedCell = indexPath
            cell.alpha = 0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "VideoVC") as! ItemVideoViewController
            vc.asset = asset
            vc.image = asset.coverImage
            vc.startTime = (cell.avPlayer.currentTime())
            vc.avPlayer = cell.avPlayer
            
            vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
            vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
            addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(vc.view)
            
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
            vc.didMove(toParent: self)
            viewControllerAssetDetail = vc
        } else if assetType == "deviceVideo" {
            let cell = collectionViewAssets!.cellForItem(at: indexPath) as! CuratedVideoCollectionViewCell
            cell.alpha = 0
            hideCells(cell)
            selectedCell = indexPath
            cell.alpha = 0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "DeviceVC") as! DeviceViewController
            vc.asset = asset
            vc.cellAvPlayer = cell.avPlayer
            
            vc.initialFrame = collectionViewAssets!.layoutAttributesForItem(at: indexPath)!.frame
            vc.initialFrame.origin.y -= CGFloat(indexPath.section)*self.view.bounds.height
            addChild(vc)
            vc.view.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(vc.view)
            
            NSLayoutConstraint.activate([
                vc.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                vc.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                vc.view.topAnchor.constraint(equalTo: view.topAnchor),
                vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
            vc.didMove(toParent: self)
            viewControllerAssetDetail = vc
        }
        
        self.view.bringSubviewToFront(self.buttonMenu)
        self.view.bringSubviewToFront(self.buttonContribute)
        self.view.bringSubviewToFront(self.pageControlAssets)
    }
    
    func hideCells(_ showCell:UICollectionViewCell) {
        initialFrames.removeAll()
        triggerEnd()
        for cell in collectionViewAssets!.visibleCells {
            if cell.frame.origin.y < 0 {
            } else {
                initialFrames.append(cell.frame)
                
                if cell != showCell {
                    cell.alpha = 1
                }
                cell.tag = Int(cell.frame.origin.x)
                if cell.frame.origin.x <= 10 {
                    UIView.animate(withDuration: 0.4, animations: {
                        cell.frame.origin.x = -cell.frame.width
                    }, completion: nil)
                } else {
                    UIView.animate(withDuration: 0.4, animations: {
                        cell.frame.origin.x = self.view.bounds.width
                    }, completion: nil)
                }
            }
            
        }
    }
    
    func showCells() {
        for cell in collectionViewAssets!.visibleCells {
            if cell.frame.origin.y < 0 {
                
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    cell.frame.origin.x = CGFloat(cell.tag)
                }, completion: { (b:Bool) in
                    cell.alpha = 1
                })
            }
        }
    }
    
    func setSections(){
        
        for el in curatedAssets {
            assets.append(el)
        }
        
        for asset in currentImprint.deviceAssets {
            if asset.1 {
                let ran = Int(arc4random_uniform(UInt32(self.assets.count)))
                assets.insert(asset.0, at: ran)
            }
        }
        assets = assets.sorted(by: {$0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970})
        for item in self.assets {
            if item.type == "deviceVideo" {
                PHImageManager.default().requestAVAsset(forVideo: item.asset!, options: PHVideoRequestOptions()) { (asset, audio, dictionary) in
                    
                    item.avPlayer = AVPlayer(playerItem: AVPlayerItem(asset: asset!))
                }
            }
        }
        
        let availableSizes = [3,4,5,6]//[2,4,5,6,7,8]
        while assets.count >= availableSizes.min()! {
            //Picks a random layour from available sizes
            let random = Int(arc4random_uniform(UInt32(availableSizes.count)))
            let randomSize = availableSizes[random]
            if assets.count >= randomSize {
                let sectionItems = Array(assets[0..<randomSize]) as [AMDAsset]
                sections.append(sectionItems)
                assets.removeSubrange(0..<randomSize)
            }
        }
        
        moveAlbumsSquare()
        
        let newImprint = AMDAsset(type: "TopTile")
        sections.insert([newImprint], at: 0)
    }
    
    func showActionButtons() {
        if isMenuOpen {
            return
        }
        buttonMenu.alpha = 1
        labelUploadClock.alpha = 1
        buttonContribute.alpha = 1
        visualEffectViewBlurMenu.alpha = 1
        visualEffectViewBlurContribute.alpha = 1
        if UploadManager.instance.uploadInProgress && !buttonContribute.isHidden {
            UIView.animate(withDuration: 0.2, animations: {
                self.buttonContribute.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { (success) in
                self.labelUploadClock.isHidden = false
                self.buttonContribute.isHidden = true
                UIView.animate(withDuration: 0.2, animations: {
                    self.labelUploadClock.transform = CGAffineTransform(scaleX: 1, y: 1)
                }) { (success) in
                    let rotation = CASpringAnimation(keyPath: "transform.rotation.z")
                    rotation.damping = 10.0
                    rotation.fromValue = 0.0
                    rotation.toValue = Float.pi
                    rotation.duration = 1
                    rotation.repeatCount = Float.infinity
                    self.labelUploadClock.layer.add(rotation, forKey: "rotation")
                }
            }
        }
    }
    
    func hideActionButtons() {
        labelUploadClock.alpha = 0
        buttonMenu.alpha = 0
        buttonContribute.alpha = 0
        visualEffectViewBlurMenu.alpha = 0
        visualEffectViewBlurContribute.alpha = 0
    }
    
    func showTutorial(step:TutorialStep) {
        if UserDefaultsManager.shouldSkipTutorial ?? false {
            return
        }
        let vcTutorial = TutorialViewController.instance(step: step)
        vcTutorial.delegate = self
        self.present(vcTutorial, animated: true, completion: nil)
    }
    
    func showFinito(animated:Bool) {
        isMenuOpen = true
        menuPanGesture = UIPanGestureRecognizer(target: self, action: #selector(menuPan(_:)))
        menuTap = UITapGestureRecognizer(target: self, action: #selector(actionCloseMenu))
        
        self.view.addGestureRecognizer(menuPanGesture)
        self.view.addGestureRecognizer(menuTap)
        
        collectionViewAssets.isUserInteractionEnabled = false
        let heightSections = CGFloat(self.sections.count-1)*self.view.bounds.height
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.collectionViewAssets.contentOffset.y = UIDevice().userInterfaceIdiom == .phone && (UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688) ? heightSections : heightSections
            self.pageControlAssets.alpha = 0
            self.visualEffectViewBlurOverview.alpha = 1
            self.collectionViewAssets.alpha = 0.5
            self.pageControlAssets.center.y = self.collectionViewAssets.center.y
        })
        
        let vcFinito = FinitoViewController.instance()
        vcFinito.delegate = self
        vcFinito.currentImprint = currentImprint
        self.present(vcFinito, animated: animated) {
        }
    }
    
    func animateUpload() {
        viewNotification = NotificationService.showNotification(view: self.labelUploading, text: "It will take couple of moments to upload your content.", emoji: "🐝", backgroundColor: UIColor.Notification.info, textColor: UIColor.Notification.infoText, paddingConstant: 20.0, padding: .bottom)
        viewNotification?.dismissable = false
        
        Animations.addAmondoLogoAnimation(imageView: imageViewUploadLoader)
        imageViewUploadLoader.startAnimating()
        
    }
    
    func showUploadCompleted() {
        imageViewUploadLoader.stopAnimating()
        if uploadOpen {
            imageViewUploadLoader.image = UIImage(named: "logo-mono")
            labelUploading.text = "🎉 Uploaded 🎉"
            viewNotification = NotificationService.showNotification(view: self.labelUploading, text: "Your content is uploaded and is awaiting for moderation.", emoji: "🙌", backgroundColor: UIColor.Notification.positive, textColor: UIColor.Notification.positiveText, paddingConstant: 20.0, padding: .bottom)
            viewNotification?.dismissable = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.closeUpload()
            }
        } else {
            viewNotification = NotificationService.showNotification(view: self.buttonContribute, text: "Your content is uploaded and is awaiting for moderation.", emoji: "🙌", backgroundColor: UIColor.Notification.positive, textColor: UIColor.Notification.positiveText, paddingConstant: 20.0, padding: .top)
            
            buttonContribute.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.2, animations: {
                self.labelUploadClock.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.labelUploadClock.layer.removeAllAnimations()
            }) { (success) in
                self.labelUploadClock.isHidden = true
                self.buttonContribute.isHidden = false
                UIView.animate(withDuration: 0.2, animations: {
                    self.buttonContribute.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
    
    func showUploadError() {
        imageViewUploadLoader.stopAnimating()
        if uploadOpen {
            imageViewUploadLoader.image = UIImage(named: "logo-mono")
            labelUploading.text = "Error Occured"
            viewNotification = NotificationService.showNotification(view: self.labelUploading, text: "There was a error while uploading the content, please try agian.", emoji: "🙌", backgroundColor: UIColor.Notification.negative, textColor: UIColor.Notification.negativeText, paddingConstant: 20.0, padding: .bottom)
            viewNotification?.dismissable = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.closeUpload()
            }
        } else {
            viewNotification = NotificationService.showNotification(view: self.buttonContribute, text: "There was a error while uploading the content, please try agian.", emoji: "🙌", backgroundColor: UIColor.Notification.negative, textColor: UIColor.Notification.negativeText, paddingConstant: 20.0, padding: .top)
        }
    }
    
    func closeUpload() {
        showActionButtons()
        pageControlAssets.isHidden = false
        layoutConstraintImprintWrapperBottom.constant = 0
        uploadOpen = false
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }) { (success) in
            self.viewUploadWrapper.isHidden = true
        }
    }
}
