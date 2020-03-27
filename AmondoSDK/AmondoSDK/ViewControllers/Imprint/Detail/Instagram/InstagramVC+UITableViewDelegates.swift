//
//  InstagramVC+UITableViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/5/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension InstagramViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -30 {
            closeAnimation()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asset.instagram!.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellComment", for: indexPath) as! CommentTableViewCell
        cell.comment = asset.instagram!.comments[indexPath.row]
        cell.prepareCell()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let commentHeight = (asset.instagram!.comments[indexPath.row]["comment"] as! String).heightForView(Fonts.sfRegular(size: 16),width:self.view.bounds.width-90)
        
        return commentHeight > 40 ? 66 + commentHeight - 40 : 66
    }
}
