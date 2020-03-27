//
//  ImprintViewController+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 7/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

extension ImprintViewController {
    
    func prepareReusableViews() {
        self.collectionViewAssets.register(UINib(nibName: "EventCollectionViewCell", bundle: Bundle(for: EventCollectionViewCell.self)), forCellWithReuseIdentifier: "cellEvent")
        self.collectionViewAssets.register(UINib(nibName: "GridImageCollectionViewCell", bundle: Bundle(for: GridImageCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridImage")
        self.collectionViewAssets.register(UINib(nibName: "GridVideoCollectionViewCell", bundle: Bundle(for: GridVideoCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridVideo")
        self.collectionViewAssets.register(UINib(nibName: "GridArticleCollectionViewCell", bundle: Bundle(for: GridArticleCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridArticle")
    }
    
    func prepareObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
    }
    
    func prepareGestures() {
        viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(gesture:)))
        viewPan.delegate = self
        collectionViewAssets.addGestureRecognizer(viewPan)
        
        viewSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewSwiped(gesture:)))
        viewSwipe.direction = .up
        viewSwipe.delegate = self
        collectionViewAssets.addGestureRecognizer(viewSwipe)
        
        let gesturePanContribute = UIPanGestureRecognizer(target: self, action: #selector(viewPannedContribute(gesture:)))
        gesturePanContribute.delegate = self
        self.viewUploadWrapper.addGestureRecognizer(gesturePanContribute)
    }

    @objc func viewSwiped(gesture: UISwipeGestureRecognizer) {
        closedImprint()
    }
    
    func prepareUI() {
        buttonContribute.layer.cornerRadius = 32
        buttonMenu.layer.cornerRadius = 32
        visualEffectViewBlurMenu.layer.cornerRadius = 32
        visualEffectViewBlurContribute.layer.cornerRadius = 32
        
        collectionViewAssets.contentInset.top = 0
        collectionViewAssets.contentOffset.y = 0
        collectionViewAssets.isScrollEnabled = true
        collectionViewAssets!.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.bounds.height, right: 0)
        collectionViewAssets.isPrefetchingEnabled = false
        
        svLeftView.constant = 0
        svRightView.constant = 0
        hideActionButtons()
        
        let frame = CGRect(x: 10, y: 500, width: 50, height: 30)
        pageControlAssets = ISPageControl(frame: frame, numberOfPages: sections.count)
        pageControlAssets.radius = 4
        pageControlAssets.padding = 5
        pageControlAssets.inactiveTintColor = UIColor.white.withAlphaComponent(0.45)
        pageControlAssets.currentPageTintColor = UIColor.white
        pageControlAssets.borderWidth = 0
        pageControlAssets.borderColor = UIColor.clear
        view.addSubview(pageControlAssets)
        view.bringSubviewToFront(pageControlAssets)
        
        pageControlAssets.alpha = 0

        pageControlAssets.center.y = self.view.bounds.height/2
        pageControlAssets.center.x = self.view.bounds.width-5
        pageControlAssets.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        
        if UIScreen.main.nativeBounds.height == 2688 || UIScreen.main.nativeBounds.height == 2436 {
            bottomSpaceLayout = 20 //TODO CHECK THIS FOR X
        }
        
    }
    
    func prepareData() {
        loadingItems = true
        setSections()
        currentImprint.loadItemsForEvent(fromVC: self) {
            
            self.loadingItems = false
            curatedAssets = self.currentImprint.items
            self.sections.removeAll()
            self.assets.removeAll()
            //self.collectionViewAssets.layoutSubviews()
            self.prepareSections()
            self.collectionViewAssets.reloadData()
            self.invalidateImprintLayout()
            
            self.resetLayout()
            UIView.animate(withDuration: 0.3, animations: {
                self.preparePageControl()
            })
            
            self.showTutorial(step: .exploreImprint)
        }
    }
    
    func preparePageControl(){
        self.view.bringSubviewToFront(self.pageControlAssets)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControlAssets.alpha = 1
        })
    }
    
    func invalidateImprintLayout() {
        let context = UICollectionViewFlowLayoutInvalidationContext()
        context.invalidateFlowLayoutAttributes = true
        context.invalidateFlowLayoutDelegateMetrics = true
        self.collectionViewAssets.collectionViewLayout.invalidateLayout(with: context)
    }
    
    func prepareSections() {
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
        assets  = assets.filter({$0.type != "error" })

        for item in self.assets {
            if item.type == "deviceVideo" {
                PHImageManager.default().requestAVAsset(forVideo: item.asset!, options: PHVideoRequestOptions()) { (asset, audio, dictionary) in
                    item.avPlayer = AVPlayer(playerItem: AVPlayerItem(asset: asset!))
                }
            }
        }
        
        //todo, fix and remember layout
        let availableSizes = [3,4,5,6]
        while assets.count >= availableSizes.min()! {
            let random = Int(arc4random_uniform(UInt32(availableSizes.count)))
            let randomSize = availableSizes[random]
            if assets.count >= randomSize {
                let sectionItems = Array(assets[0..<randomSize]) as [AMDAsset]
                sections.append(sectionItems)
                assets.removeSubrange(0..<randomSize)
            }
        }
        
        moveAlbumsSquare()
        sectionAssets = sections.flatMap{$0}

        let newImprint = AMDAsset(type: "TopTile")
        sections.insert([newImprint], at: 0)
    }
    
    func prepareImprintLayout() {
        imprintLayout.delegate = self
        collectionViewAssets!.collectionViewLayout = imprintLayout
        
        let path = Bundle.main.path(forResource: "LayoutsAll", ofType: "plist")
        layoutConfigs = NSDictionary(contentsOfFile: path!)!
    }
    
}
