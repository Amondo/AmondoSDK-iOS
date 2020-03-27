//
//  SelectMediaViewController+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/28/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension SelectMediaViewController {

    @IBAction func actionBack() {
        if buttonGoBack.titleLabel?.text == "Try Again?" { //temp solution!
            actionContribute()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func actionContribute() {
        navigationBack()
        delegate?.uploadStart(assets: selectedMedia)
    }

}
