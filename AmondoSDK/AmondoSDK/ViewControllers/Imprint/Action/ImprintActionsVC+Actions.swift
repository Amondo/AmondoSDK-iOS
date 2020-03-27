//
//  ImprintActionsVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/2/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Social
import MessageUI
import FacebookShare

extension ImprintActionsViewController {
    
    @IBAction func actionClose() {
        if isJustShare {
            delegate?.imprintActionsClosedJustShare()
        } else {
            delegate?.imprintActionsClosed()
        }
    }

    func actionShare() {
        if UIScreen.main.nativeBounds.height == 2688 || UIScreen.main.nativeBounds.height == 2436 {
            layoutConstraintOptionsBottom.constant = 0
        } else {
            layoutConstraintOptionsBottom.constant = 24
        }
        
        self.isShareOpen = true
        tableViewActions.reloadData()
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func actionCancel() {
        if isShareOpen {
            if UIScreen.main.nativeBounds.height == 2688 || UIScreen.main.nativeBounds.height == 2436 {
                layoutConstraintOptionsBottom.constant = -260;
            } else {
                layoutConstraintOptionsBottom.constant = -234;
            }
            
            self.isShareOpen = false
            tableViewActions.reloadData()
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            if isJustShare {
                delegate?.imprintActionsClosedJustShare()
            } else {
                delegate?.imprintActionsClosed()
            }
        }
    }
    
    func actionMore() {
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func actionCopyLink() {
        logShare(action: "Copy")
        
        if customurl != nil {
            UIPasteboard.general.string = customurl
        } else {
            let url = "https://amo.im/"+(imprint.slug ?? "")
            UIPasteboard.general.string = url
        }
        let label = UILabel(frame: CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 40))//)
        label.textAlignment = .center
        label.text = "Copied link!"
        label.font = Fonts.sfSemiBold(size: 15)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        self.view.addSubview(label)
        UIView.animate(withDuration: 0.3, animations: {
            label.frame.origin.y = self.view.bounds.height-40
        }) { (b:Bool) in
            UIView.animate(withDuration: 0.3, delay: 2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                label.frame.origin.y = self.view.bounds.height
            }, completion: { (done) in
                label.removeFromSuperview()
            })
        }
    }
    
    func actionReport() {
        logShare(action: "Email")
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    func actionTwitter() {
        logShare(action: "Twitter")
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText(shareText)
            
            self.present(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please log in to a Twitter account in your iOS settings to share.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func actionWhatsapp() {
        logShare(action: "Whatsapp")
        let msg = shareText
        let urlWhats = "whatsapp://send?text=\(msg)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    // Cannot open whatsapp
                    var alert = UIAlertController(title: "Accounts", message: "Please log in to a Whatsapp account to share.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func actionMessanger() {
        logShare(action: "Messenger")
//        let url = "https://amo.im/"+(imprint.slug ?? "")
//        let shareText="Check out my \(self.imprint!.event!.artist!) Imprint created by @helloamondo #amondo #imprint"
//        var content = LinkShareContent(url:  URL(string:url)!, quote: shareText)
//        if customurl != nil {
//            content = LinkShareContent(url:  URL(string:customurl!)!, quote: shareText)
//        }
//        
//        let shareDialog = MessageDialog(content: content)
//        shareDialog.completion = { result in
//            // Handle share results
//        }
//        
//        do {
//            try shareDialog.show()
//        } catch {
//            var alert = UIAlertController(title: "Accounts", message: "Please log in to a Messenger account to share.", preferredStyle: UIAlertControllerStyle.alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    func actionFacebook() {
        logShare(action: "Facebook")
//        let url = "https://amo.im/"+(imprint.slug ?? "")
//        let shareText="Check out my \(self.imprint!.event!.artist!) Imprint created by @helloamondo #amondo #imprint"
//
//        var content = LinkShareContent(url:  URL(string:url)!, quote: shareText)
//        if customurl != nil {
//            content = LinkShareContent(url:  URL(string:customurl!)!, quote: shareText)
//        }
//
//        do {
//            try ShareDialog.show(from: self, content: content) { (result) in
//
//            }
//        } catch {
//
//        }
    }
    
    func actionMessage() {
        logShare(action: "Message")
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = self.shareText
            controller.recipients = []
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Can not send iMessage from this device", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
