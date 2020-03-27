//
//  CommentTableViewCell+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/5/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension CommentTableViewCell {
    
    func prepareGfx() {
        selectionStyle = .none
        labelUsername.font = Fonts.sfSemiBold(size: 10)
        labelUsername.textColor = Colors.white.withAlphaComponent(0.7)
        labelComment.font = Fonts.sfRegular(size: 16)
        labelComment.textColor = Colors.white
    }
    
    func prepareData() {
        imageViewAvatar.image = nil
        labelComment.text = comment["comment"] as? String
        labelUsername.text = comment["username"] as? String
        if let avatar = comment["avatar"] as? Dictionary<String, Any> {
            let file = AMDFile(file: avatar, ftype: "icon")
            file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
                if error == nil {
                    let img = UIImage(data: data!)
                    self.imageViewAvatar.image = img
                }
            })
        }
    }
    
    func prepareCell() {
        prepareData()
        prepareGfx()
    }
    
}
