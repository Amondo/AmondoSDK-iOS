//
//  ContributeMediaCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/16/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ContributeMediaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewThumb: UIImageView!
    @IBOutlet weak var imageViewSelected: UIImageView!
    @IBOutlet weak var labelVideoDuration: UILabel!

    var asset: AMDAsset!
    var isMediaSelected: Bool!

}
