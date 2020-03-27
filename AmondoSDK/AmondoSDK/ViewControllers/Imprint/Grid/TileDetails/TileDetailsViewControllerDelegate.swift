//
//  TileDetailsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/28/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

protocol TileDetailsViewControllerDelegate: NSObjectProtocol {
    
    func tileDetailsPrevious(tileDetailsVC: TileDetailsViewController, asset:  AMDAsset)
    func tileDetailsNext(tileDetailsVC: TileDetailsViewController, asset:  AMDAsset)
    func tileDetailsClose()
    
}
