//
//  ImprintVC+UIPageViewControllerDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 1/28/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let asset = sectionAssets[selectedItem-1]
        //let vc = viewControllerForAsset(asset: asset, indexPath: nil)
        selectedItem = selectedItem - 1
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let asset = sectionAssets[selectedItem+1]
        //let vc = viewControllerForAsset(asset: asset, indexPath: nil)
        selectedItem = selectedItem + 1
        
        return nil
    }
    
    
}
