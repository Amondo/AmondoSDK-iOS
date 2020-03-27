//
//  GridScrollerCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class GridScrollerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var collectionViewItems: UICollectionView!
    var gridItem: GridItem!
    var delegate: GridScrollerCollectionViewCellDelegate?
    var activeDownloads: [DataRequest]?
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    func prepareCell() {
        prepareReusableViews()
        prepareGfx()
        prepareData()
    }
    
}
