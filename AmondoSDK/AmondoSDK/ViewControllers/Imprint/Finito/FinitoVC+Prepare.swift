//
//  FinitoVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension FinitoViewController {
    
    func prepareReusableViews() {
        self.tableViewOptions.register(UINib(nibName: "ImprintActionTableViewCell", bundle: Bundle(for: ImprintActionTableViewCell.self)), forCellReuseIdentifier: "cellImprintAction")
    }
    
    func prepareUI() {
        viewHeader.layer.cornerRadius = 20
        labelFinito.font = Fonts.sfBold(size: 22)
        labelWhatsNext.font = Fonts.sfRegular(size: 14)
    }
    
}
