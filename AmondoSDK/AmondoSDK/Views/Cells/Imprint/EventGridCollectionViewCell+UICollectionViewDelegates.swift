//
//  EventGridCollectionViewCell+UICollectionViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 8/14/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension EventGridCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (menuSection?.items.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEvent", for: indexPath) as! EventCollectionViewCell
        cell.item = menuSection?.items[indexPath.row]
        cell.indexPath = indexPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellEvent = cell as! EventCollectionViewCell
        let item = menuSection!.items[indexPath.row]
        cellEvent.prepareForReuse()
        cellEvent.prepareCell(item: item, indexPath: indexPath)
        cellEvent.adjustToGridView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width*12/25
        return CGSize(width: width, height: width*13/9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = menuSection!.items[indexPath.row]
        NotificationCenter.default.post(name: Notification.Name("IMPRINT_OPEN"), object: item)
    }
    
}
