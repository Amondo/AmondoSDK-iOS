//
//  ImpringGridVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintGridViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImprintActionsViewController {
            if segue.identifier == "segueImprintShare" {
                vc.isJustShare = true
            }
            vc.imprint = imprint
            vc.delegate = self
        }
    }
    
    func prepareReusableViews() {
        collectionViewImprint.register(UINib(nibName: "GridSplashReusableView", bundle: Bundle(for: GridSplashReusableView.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableViewGridSplash")
        collectionViewImprint.register(UINib(nibName: "GridHeaderReusableView", bundle: Bundle(for: GridHeaderReusableView.self)), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "reusableViewGridHeader")
        
        ImprintGridUtil.registerCells(collectionView: collectionViewImprint)
        collectionViewImprint.register(UINib(nibName: "GridScrollerCollectionViewCell", bundle: Bundle(for: GridScrollerCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridScroller")
        collectionViewImprint.register(UINib(nibName: "GridGroupCollectionViewCell", bundle: Bundle(for: GridGroupCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridGroup")
    }
    
    func prepareGestures() {
        gesturePan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(gesture:)))
        gesturePan.delegate = self
        collectionViewImprint.addGestureRecognizer(gesturePan)
        
        gestureSwipe = UISwipeGestureRecognizer(target: self, action: #selector(viewSwiped(gesture:)))
        gestureSwipe.direction = .up
        gestureSwipe.delegate = self
        collectionViewImprint.addGestureRecognizer(gestureSwipe)
        
        let gesturePanContribute = UIPanGestureRecognizer(target: self, action: #selector(viewPannedContribute(gesture:)))
        gesturePanContribute.delegate = self
        self.viewUploadWrapper.addGestureRecognizer(gesturePanContribute)
    }
    
    func prepareGfx() {
        let layout = collectionViewImprint.collectionViewLayout as? UICollectionViewFlowLayout // casting is required because UICollectionViewLayout doesn't offer header pin. Its feature of UICollectionViewFlowLayout
        layout?.sectionHeadersPinToVisibleBounds = true
        //collectionViewImprint.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0)
        if #available(iOS 11.0, *) {
            collectionViewImprint.alwaysBounceVertical = false
            collectionViewImprint.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        viewContributeWrapper.layer.cornerRadius = 32
        viewContributeWrapper.layer.masksToBounds = true
        viewMenuWrapper.layer.cornerRadius = 32
        viewMenuWrapper.layer.masksToBounds = true
        
        let heightTitle = imprint.event?.artist?.uppercased().heightNeeded(maxWidth: UIScreen.main.bounds.width-80, font: Fonts.condensedBoldWithSize(size: 20))
        if CGFloat(heightTitle!) > CGFloat(24.0) {
            heightHeader = 134
        }
        
        if UIScreen.main.nativeBounds.height < 2436 {
            heightHeader = heightHeader - 20
        }

    }
    
    func prepareObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(closeImprint), name: NSNotification.Name(rawValue: "ImprintClose"), object: nil)
    }
    
    func prepareData() {
        hideActionButtons()
        imprint.loadItemsForEvent(fromVC: self) {
            self.imprint.grid = GridTemplate.generate(imprint: self.imprint)
            self.collectionViewImprint.reloadData()
            var sum: CGFloat = -355.0
            let items = self.imprint.grid?.items
            items?.forEach({ (item) in
                sum += item.height
            })
            self.heightTotal = sum
            if !self.gridStyle.presentSplash {
                self.heightTotal -= UIScreen.main.bounds.height
            }
        }
    }
}
