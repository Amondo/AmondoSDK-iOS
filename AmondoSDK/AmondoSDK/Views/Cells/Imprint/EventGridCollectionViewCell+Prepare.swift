//
//  EventGridCollectionViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/14/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension EventGridCollectionViewCell {
    
    func prepareReusableViews() {
        self.collectionViewImprints.register(UINib(nibName: "EventCollectionViewCell", bundle: Bundle(for: EventCollectionViewCell.self)), forCellWithReuseIdentifier: "cellEvent")
    }
    
    func prepareGfx() {
        self.collectionViewImprints.contentInset = UIEdgeInsets(top: 0, left: 3, bottom: 90, right: 3)
    }
    
    func prepareData() {
        collectionViewImprints.reloadData()
    }
    
    func prepareCell() {
        prepareReusableViews()
        prepareData()
        prepareGfx()
    }
    
}
