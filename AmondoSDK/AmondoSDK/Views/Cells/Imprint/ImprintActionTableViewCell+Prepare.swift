//
//  ImprintActionTableViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ImprintActionTableViewCell {
    
    func prepareGfx() {
        self.labelName.font = Fonts.sfRegular(size: 16)
        self.labelName.textColor = Colors.white
        if isFinito {
            layoutConstraintStackLeading.priority = UILayoutPriority(rawValue: 250)
            layoutConstraintStackCenter.priority = UILayoutPriority(rawValue: 750)
            if (UIScreen.main.bounds.width == 320) {
                layoutConstraintWrapperLeading.constant = -27
            }
        } else {
            layoutConstraintStackCenter.priority = UILayoutPriority(rawValue: 250)
            layoutConstraintStackLeading.priority = UILayoutPriority(rawValue: 750)
        }
        layoutIfNeeded()
    }
    
    func prepareData() {
        switch actionType {
        case .cancel:
            labelName.text = "Cancel"
            imageViewAction.image = #imageLiteral(resourceName: "close-x")
        case .more:
            labelName.text = "More"
            imageViewAction.image = #imageLiteral(resourceName: "more")
        case .chat:
            labelName.text = "Chat with Amondo"
            imageViewAction.image = isFinito ? #imageLiteral(resourceName: "chat-gray")  : #imageLiteral(resourceName: "chat-bubble")
        case .report:
            labelName.text = "Report this Imprint"
            imageViewAction.image = #imageLiteral(resourceName: "report")
        case .friends:
            labelName.text = "Get Friend's Photos & Videos"
            imageViewAction.image = #imageLiteral(resourceName: "friends")
        case .share:
            labelName.text = "Share this imprint"
            imageViewAction.image = isFinito ? #imageLiteral(resourceName: "share-gray")  : #imageLiteral(resourceName: "share")
        case .messages:
            labelName.text = "Messages"
            imageViewAction.image = #imageLiteral(resourceName: "messages")
        case .whatsapp:
            labelName.text = "Whatsapp"
            imageViewAction.image = #imageLiteral(resourceName: "whatsapp")
        case .messanger:
            labelName.text = "Messenger"
            imageViewAction.image = #imageLiteral(resourceName: "messanger")
        case .facebook:
            labelName.text = "Facebook"
            imageViewAction.image = #imageLiteral(resourceName: "facebook")
        case .twitter:
            labelName.text = "Twitter"
            imageViewAction.image = #imageLiteral(resourceName: "twitter")
        case .link:
            labelName.text = "Copy Link"
            imageViewAction.image = #imageLiteral(resourceName: "link")
        case .none:
            labelName.text = ""
            imageViewAction.image = nil
        case .viewAgain:
            labelName.text = "View again"
            imageViewAction.image = isFinito ? #imageLiteral(resourceName: "reload-gray") : #imageLiteral(resourceName: "reload")
        case .backToGallery:
            labelName.text = "Back to imprints"
            imageViewAction.image = isFinito ? #imageLiteral(resourceName: "back-gray")  : #imageLiteral(resourceName: "backgallery")
        }
    }
    
    func prepareCell() {
        prepareData()
        prepareGfx()
    }
    
}
