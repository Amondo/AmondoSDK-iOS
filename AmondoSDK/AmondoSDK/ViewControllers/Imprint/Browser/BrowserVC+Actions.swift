//
//  BrowserVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/18/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension BrowserViewController {
    
    @IBAction func actionDone() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionBack() {
        webView.goBack()
    }
    
    @IBAction func actionForward() {
        webView.goForward()
    }
    
    @IBAction func actionOpenSafari() {
        UIApplication.shared.open(url)
    }
    
    @IBAction func actionShare() {
        let text = "I discovered this in Amondo app " + url.absoluteString
        let textShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}
