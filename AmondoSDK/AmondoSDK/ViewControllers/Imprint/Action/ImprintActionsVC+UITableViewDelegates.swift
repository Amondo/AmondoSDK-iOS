//
//  ImprintActionsVC+UITableViewDelegates.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Intercom

extension ImprintActionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShareOpen || isJustShare ? share.count : options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewActions.dequeueReusableCell(withIdentifier: "cellImprintAction", for: indexPath) as! ImprintActionTableViewCell
        cell.actionType = isShareOpen || isJustShare ? share[indexPath.row] : options[indexPath.row]
        cell.selectionStyle = .none
        cell.prepareCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let action = isShareOpen || isJustShare ? share[indexPath.row] : options[indexPath.row]
        switch action {
        case .share:
            actionShare()
        case .cancel:
            actionCancel()
        case .more:
            actionMore()
        case .report:
            actionReport()
        case .chat:
            Intercom.presentMessageComposer()
        case .friends:
            print("none found")
        case .messages:
            actionMessage()
        case .whatsapp:
            actionWhatsapp()
        case .messanger:
            actionMessanger()
        case .facebook:
            actionFacebook()
        case .twitter:
            actionTwitter()
        case .link:
            actionCopyLink()
        default:
            print("none")
        }

        view.layoutIfNeeded()
    }
    
}
