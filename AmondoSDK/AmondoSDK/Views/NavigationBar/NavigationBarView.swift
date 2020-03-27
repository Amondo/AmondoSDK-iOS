//
//  NavigationBarView.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/1/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class NavigationBarView: UIView {
    
    enum RightActionType: String {
        case none
        case settings
    }
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet var buttonBack: UIButton!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var buttonActionRight: UIButton!
    
    var rightActionType: RightActionType = .none
    var delegate: NavigationBarViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareXib()
    }
    
}
