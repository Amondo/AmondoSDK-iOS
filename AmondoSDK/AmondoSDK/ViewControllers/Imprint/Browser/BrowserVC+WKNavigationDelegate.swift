//
//  BrowserVC+WKWebViewDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/22/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import WebKit

extension BrowserViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        prepareBrowserButtons()
    }
    
    
}
