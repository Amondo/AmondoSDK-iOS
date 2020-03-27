//
//  GridHeaderReusableView.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class GridHeaderReusableView: UICollectionReusableView {
    
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    
    @IBOutlet weak var layoutConstraintHeroHeight: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintProgressTrailing: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintInfoBottom: NSLayoutConstraint!
    
    var imprint: AMDImprintItem!
    var firstRender: Bool = false
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    func prepareReusableView() {
        prepareGfx()
        prepareData()
    }
    
}
