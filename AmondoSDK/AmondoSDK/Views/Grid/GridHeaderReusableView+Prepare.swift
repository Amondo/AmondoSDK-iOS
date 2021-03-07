//
//  GridHeaderReusableView+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension GridHeaderReusableView {
    
    func prepareGfx() {
        labelTitle.font = gridStyle.headerTitleFont
        labelTitle.lineBreakMode = .byClipping
        labelTitle.adjustsFontSizeToFitWidth = true
        labelTitle.minimumScaleFactor = 0.8
        labelTitle.textColor = Colors.white
        labelInfo.font = gridStyle.headerInfoFont
        labelInfo.textColor = Colors.silver
        
        layoutConstraintHeroHeight.constant = UIScreen.main.bounds.size.height
        layoutConstraintProgressTrailing.constant = UIScreen.main.bounds.size.width
        if #available(iOS 11.0, *) {
            if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(0.0)) {
                layoutConstraintInfoBottom.constant = 42.0
            }
        }
        
        layoutIfNeeded()
    }
    
    func prepareData() {
        labelTitle.text = imprint.event?.artist?.uppercased()
        if imprint.event?.date != nil {
            labelInfo.text = (imprint.event?.location?.uppercased())! + " · " + (imprint.event?.date?.stringEvent(showYear: false).uppercased())!
        }
        print("imprint",imprint)
        print("img",imprint.image)
        print("ao",imprint.object)
        if imprint.image == nil {
            if let data = imprint.imageMeta {
                data.getDataInBackground(completion: { (error:Error?, data:Data?, cached:Bool) in
                    if error == nil {
                        if self.imageViewCover.image == nil {
                            self.imprint.image = UIImage(data:data!)
                            self.imageViewCover.image = UIImage(data:data!)
                            self.imageViewCover.animateOpacity(alpha: 1, duration: 0.3)
                        }
                    }
                })
            } else {
                imageViewCover.alpha = 0
                imageViewCover.image = nil
            }
        } else {
            imageViewCover.alpha = 1
            imageViewCover.image = imprint.image
        }
    }
    
}
