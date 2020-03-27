//
//  CommentTableViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/5/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewAvatar: UIImageView!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelComment: UILabel!
    
    var comment: [String: AnyObject]!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageViewAvatar.image = nil
    }
}
