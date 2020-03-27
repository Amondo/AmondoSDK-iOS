//
//  FinitioVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension FinitoViewController {
    
    @IBAction func actionClose() {
        delegate?.finitoClose()
    }
    
    func actionShare() {
        delegate?.finitoShare()
    }
    
    func actionViewAgain() {
//        IMPRINTVC?.pageControlAssets.currentPage = 0
//        IMPRINTVC!.collectionViewAssets.contentOffset.y = UIDevice().userInterfaceIdiom == .phone && ( UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688 ) ? 0 : 20
        delegate?.finitoViewAgain()
    }
    
}
