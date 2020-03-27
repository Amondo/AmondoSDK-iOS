//
//  FinitoVC+UITableViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Intercom

extension FinitoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOptions.dequeueReusableCell(withIdentifier: "cellImprintAction", for: indexPath) as! ImprintActionTableViewCell
        cell.actionType = options[indexPath.row]
        cell.selectionStyle = .none
        cell.isFinito = true
        cell.prepareCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = options[indexPath.row]
        switch action {
        case .viewAgain:
            actionViewAgain()
        case .backToGallery:
            print("close")
            //IMPRINTVC?.closedImprint()
        case .share:
            actionShare()
        case .chat:
            Intercom.presentMessageComposer()
        default:
            print("none found")
        }
        
        view.layoutIfNeeded()
    }
    
}
