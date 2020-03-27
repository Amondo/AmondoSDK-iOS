//
//  GridScrollerCollectionViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension GridScrollerCollectionViewCell {
    
    func prepareReusableViews() {
        ImprintGridUtil.registerCells(collectionView: collectionViewItems)
    }
    
    func prepareGfx() {

    }
    
    func prepareData() {
        collectionViewItems.reloadData()
    }
}
