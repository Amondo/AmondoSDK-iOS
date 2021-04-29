//
//  EventCollectionViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 5/30/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension EventCollectionViewCell {
    
    func prepareSafeArea(){
        if UIScreen.main.nativeBounds.height == 2688 || UIScreen.main.nativeBounds.height == 2436 {
            layoutConstraintInfoViewBottom.constant = 34
            layoutConstraintActionTopSuper.constant = 44
            layoutIfNeeded()
        } else {
            layoutConstraintActionTopSuper.constant = 34
        }
    }
    
    func prepareGfx() {
        labelArtist.font = Fonts.condensedBoldWithSize(size: 36)
        labelArtist.text = item.event?.artist?.uppercased()
        labelArtist.numberOfLines = 0
        labelArtist.lineBreakMode = .byClipping
        labelArtist.adjustsFontSizeToFitWidth = true
        labelArtist.minimumScaleFactor = 0.8
        labelArtist.textColor = Colors.white
        
        labelLocationDate.font = Fonts.interBold(size: 10)
        labelLocationDate.textColor = Colors.white
        labelLocationDate.alpha = 0.6
        
        viewActionBlurView.layer.cornerRadius = 18
        viewActionBlurView.layer.masksToBounds = true
    }
    
    func prepareData(item:AMDImprintItem, indexPath:IndexPath) {
        self.item = item
        self.indexPath = indexPath
        
        if item.event?.date != nil {
            labelLocationDate.text = (item.event?.location?.uppercased())! + " · " + (item.event?.date?.stringEvent(showYear: false).uppercased())!
        }
        
        if item.image == nil {
            if let data = item.imageMeta {
                data.getDataInBackground(completion: { (error:Error?, data:Data?, cached:Bool) in
                    if error == nil {
                        if self.imageViewArtist.image == nil {
                            if indexPath == self.indexPath {
                                self.item.image = UIImage(data:data!)
                                self.imageViewArtist.image = UIImage(data:data!)
                                self.imageViewArtist.animateOpacity(alpha: 1, duration: 0.3)
                            }
                        }
                    }
                })
            } else {
                imageViewArtist.alpha = 0
                imageViewArtist.image = nil
            }
        } else {
            imageViewArtist.alpha = 1
            imageViewArtist.image = item.image
        }
        
		item.notified = ((AMDUser.currentUser()!.notifiedEvents?.contains(item.objectID())) != nil)
        
        if item.status == .upcoming {
            buttonAction.isUserInteractionEnabled = false            
            buttonAction.isSelected = item.notified
            buttonAction.setImage(UIImage(named:"bell-selected"), for: .selected)
            buttonAction.setImage(UIImage(named:"bell"), for: .normal)
            buttonAction.imageEdgeInsets = UIEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
        } else {
            buttonAction.isUserInteractionEnabled = true
			buttonAction.isSelected = ((AMDUser.currentUser()!.events_users?.contains(item.objectID())) != nil)
            buttonAction.setImage(UIImage(named:"favourite-selected"), for: .selected)
            buttonAction.setImage(UIImage(named:"favourite"), for: .normal)
            buttonAction.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        }
        
        if item.notified && item.status == .upcoming {
            labelIndicator.isHidden = false
        } else {
            labelIndicator.isHidden = true
        }
    }
    
    func prepareCell(item:AMDImprintItem, indexPath:IndexPath) {
        prepareData(item:item, indexPath:indexPath)
        prepareGfx()
    }
    
}
