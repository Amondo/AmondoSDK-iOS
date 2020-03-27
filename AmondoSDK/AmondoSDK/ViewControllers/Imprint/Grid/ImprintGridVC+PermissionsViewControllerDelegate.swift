//
//  ImprintGridVC+PermissionsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintGridViewController: PermissionsViewControllerDelegate {
    
    func permissionsClosed() {
        dismiss(animated: true, completion: nil)
    }
    
    func permissionsApproved() {
        dismiss(animated: true) {
            let galleryMedia = self.imprint.populateSectionsForImprintNew()
            if galleryMedia.count > 0 {
                let story: UIStoryboard = UIStoryboard(name: "Contribute", bundle: Bundle(for: SelectMediaViewController.self))
                let vc = story.instantiateInitialViewController() as! SelectMediaViewController
                vc.imprintItem = self.imprint
                vc.delegate = self
                
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vcPermissions = PermissionsViewController.instance(type: .camera)
                vcPermissions.delegate = self
                vcPermissions.noMedia = true
                
                self.present(vcPermissions, animated: true) {
                }
            }
        }
    }
    
}
