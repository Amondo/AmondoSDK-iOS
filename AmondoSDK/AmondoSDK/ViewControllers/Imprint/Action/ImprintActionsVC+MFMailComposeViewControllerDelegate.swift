//
//  ImprintActionsVC+MFMailComposeViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import MessageUI

extension ImprintActionsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let shareText = "Imprint: \(imprint.event!.artist!) : \(imprint.objectID()) @ \(imprint.event!.location!) on \(imprint.event!.date!.postgrestDate()) \nReason: "
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["report@amondo.com"])
        mailComposerVC.setSubject("Amondo: Report Inappropriate Content")
        mailComposerVC.setMessageBody(shareText, isHTML: false)
        
        return mailComposerVC
    }
    
}
