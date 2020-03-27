//
//  NavigationBarView+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/1/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension NavigationBarView {
    
    func prepareXib() {
        Bundle.main.loadNibNamed("NavigationBarView", owner: self, options: nil)
        addSubview(viewContent)
        viewContent.frame = self.bounds
        viewContent.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func prepare() {
        prepareUI()
        prepareData()
    }
    
    func prepareUI() {
        labelTitle.font = Fonts.sfSemiBold(size: 15)
        buttonBack.titleLabel?.font = Fonts.sfSemiBold(size: 15)
    }
    
    func prepareData() {
    }
}
