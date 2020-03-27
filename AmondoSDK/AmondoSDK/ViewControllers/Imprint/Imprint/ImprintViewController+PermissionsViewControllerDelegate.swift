//
//  ImprintViewController+PermissionsViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 11/8/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintViewController: PermissionsViewControllerDelegate {
    
    func permissionsClosed() {
        dismiss(animated: true, completion: nil)
    }
    
    func permissionsApproved() {
        dismiss(animated: true) {
            let galleryMedia = self.currentImprint.populateSectionsForImprintNew()
            if galleryMedia.count > 0 {
                let story: UIStoryboard = UIStoryboard(name: "Contribute", bundle: Bundle.main)
                let vc = story.instantiateInitialViewController() as! SelectMediaViewController
                vc.imprintItem = self.currentImprint
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
