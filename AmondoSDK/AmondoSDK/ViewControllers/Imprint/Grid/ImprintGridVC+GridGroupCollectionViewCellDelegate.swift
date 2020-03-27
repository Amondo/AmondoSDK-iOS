//
//  ImprintGridVC+GridGroupCollectionViewCellDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension ImprintGridViewController: GridGroupCollectionViewCellDelegate {
    
    func gridGroupCellOpen(tile: AMDAsset) {
        openTile(tile: tile)
    }
    
}
