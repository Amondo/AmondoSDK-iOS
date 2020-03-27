//
//  GridGroupCollectionViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension GridGroupCollectionViewCell {
    
    func prepareReusableViews() {
        ImprintGridUtil.registerCells(collectionView: collectionViewItems)
    }
    
    func prepareData() {
        let contentFlowLayout: GridCollectionViewFlowLayout = GridCollectionViewFlowLayout()
        contentFlowLayout.delegate = self
        contentFlowLayout.contentPadding = ItemsPadding(horizontal: 2, vertical: 0)
        contentFlowLayout.cellsPadding = ItemsPadding(horizontal: 4, vertical: 4)
        contentFlowLayout.contentAlign = .left
        contentFlowLayout.calculateCollectionViewCellsFrames()

        collectionViewItems.collectionViewLayout = contentFlowLayout
        collectionViewItems.reloadData()

    }
}
