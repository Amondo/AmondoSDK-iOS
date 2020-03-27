//
//  ImprintActionTableViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

enum ImprintActionType: String {
    case cancel
    case more
    case report
    case chat
    case friends
    case share
    case messages
    case whatsapp
    case messanger
    case facebook
    case twitter
    case link
    case viewAgain
    case backToGallery
    case none
}

class ImprintActionTableViewCell: UITableViewCell {
    
    @IBOutlet var imageViewAction: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var stackViewVertical: UIStackView!
    
    @IBOutlet var layoutConstraintStackLeading: NSLayoutConstraint!
    @IBOutlet var layoutConstraintStackCenter: NSLayoutConstraint!
    @IBOutlet var layoutConstraintWrapperLeading: NSLayoutConstraint!
    
    var actionType: ImprintActionType = .none
    var isFinito: Bool = false
    
}
