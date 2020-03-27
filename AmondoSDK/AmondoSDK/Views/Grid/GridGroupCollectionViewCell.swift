//
//  GridGroupCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class GridGroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var collectionViewItems: UICollectionView!
    var gridItem: GridItem!
    var delegate: GridGroupCollectionViewCellDelegate?
    var activeDownloads: [DataRequest]!
    var gridStyle: ImprintGridStyle = ImprintGridStyle()

    func prepareCell() {
        prepareReusableViews()
        prepareData()
    }
    
}
