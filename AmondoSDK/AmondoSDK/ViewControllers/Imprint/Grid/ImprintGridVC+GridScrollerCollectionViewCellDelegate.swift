//
//  ImprintGridVC+GridScrollerCollectionViewCellDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension ImprintGridViewController: GridScrollerCollectionViewCellDelegate {
    
    func gridScrollerCellOpen(tile: AMDAsset) {
        openTile(tile: tile)
    }
    
}

