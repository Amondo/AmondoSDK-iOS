//
//  ImprintActionsVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintActionsViewController {
    
    func prepareUI() {
        view.layoutIfNeeded()
        viewOptionsWrapper.roundCorners(corners: [.topLeft , .topRight] , radius: 20)
        if isJustShare {
            if UIScreen.main.nativeBounds.height == 2688 || UIScreen.main.nativeBounds.height == 2436 {
                layoutConstraintOptionsBottom.constant = 0;
            } else {
                layoutConstraintOptionsBottom.constant = 24;
            }
        } else {
            if UIScreen.main.nativeBounds.height == 2688 || UIScreen.main.nativeBounds.height == 2436 {
                layoutConstraintOptionsBottom.constant = -260;
            } else {
                layoutConstraintOptionsBottom.constant = -234;
            }
        }
        view.layoutIfNeeded()
        
    }
    
    func prepareData() {
        let url = "https://amo.im/"+(imprint.slug ?? "")
        shareText = "Check out my \(imprint!.event!.artist!) Imprint \(url) created by @helloamondo #amondo #imprint"
        
        let eventID = imprint!.event!.id
        
        AMDUserAssetUploader.getEventSlug(event: eventID!) { (error:AMDError?, slug:String?) in
            if slug != nil {
                let nurl = "https://amo.im/p/"+slug!
                self.customurl = nurl
                self.shareText = "Check out my \(self.imprint!.event!.artist!) Imprint \(nurl) created by @helloamondo #amondo #imprint"
                if self.asset != nil {
                    self.customurl = "https://amondo.com/\(slug ?? "")?t=\(self.asset?.objectId() ?? "")"
                    self.shareText = "Check out my \(self.imprint!.event!.artist!) Imprint \(self.customurl ?? "") created by @helloamondo #amondo #imprint"
                }
            } else {
                self.customurl = url
                self.shareText = "Check out my \(self.imprint!.event!.artist!) Imprint \(url) created by @helloamondo #amondo #imprint"
                if self.asset != nil {
                    self.customurl = "https://amondo.com/\(self.imprint.slug ?? "")?t=\(self.asset?.objectId() ?? "")"
                    self.shareText = "Check out my \(self.imprint!.event!.artist!) Imprint \(self.customurl ?? "") created by @helloamondo #amondo #imprint"
                }
            }
        }

    }
    
    func prepareReusableViews() {
        self.tableViewActions.register(UINib(nibName: "ImprintActionTableViewCell", bundle: Bundle(for: ImprintActionTableViewCell.self)), forCellReuseIdentifier: "cellImprintAction")
    }
    
}
