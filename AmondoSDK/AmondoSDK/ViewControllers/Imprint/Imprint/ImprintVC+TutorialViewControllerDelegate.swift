//
//  ImprintVC+TutorialViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/12/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
extension ImprintViewController: TutorialViewControllerDelegate {
    
    func skipTutorial() {
        UserDefaultsManager.shouldSkipTutorial = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissTutorial() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func gestureTaken(step: TutorialStep) {
        switch step {
        case .exploreImprint:
            dismissTutorial()
            if #available(iOS 11.0, *) {
                collectionViewAssets.contentInsetAdjustmentBehavior = .never
            }
            collectionViewAssets.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
        case .closeTile:
            dismissTutorial()
            viewControllerAssetDetail?.perform(Selector(("closeAnimation")))
        case .openTile:
            dismissTutorial()
            hideActionButtons()
            let item = sections[1][0]
            showDetailViewForAsset(item, atIndex: IndexPath(row: 0, section: 1))
        case .contribute:
            self.dismiss(animated: true) {
                self.actionContribute()
                //UserDefaultsManager.shouldSkipTutorial = true
            }
        }
    }
    
}
