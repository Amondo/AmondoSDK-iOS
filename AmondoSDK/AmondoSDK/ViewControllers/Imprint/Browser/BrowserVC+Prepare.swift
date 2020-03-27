//
//  BrowserVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/18/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import WebKit

extension BrowserViewController {
    
    func prepareUI() {
        view.layoutIfNeeded()
        webView = WKWebView(frame: viewWebWrapper.bounds)
        webView.backgroundColor = Colors.trueBlack
        webView.scrollView.backgroundColor = Colors.trueBlack
        webView.isOpaque = false
        webView.navigationDelegate = self
        viewWebWrapper.addSubview(webView)
        prepareBrowserButtons()
    }
    
    func prepareData() {
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        let domain = url?.host
        labelTitle.text = domain?.replacingOccurrences(of: "www.", with: "")
    }
    
    func prepareBrowserButtons() {
        let imgBack = webView.canGoBack ? UIImage(named: "arrow-left-yellow") : UIImage(named: "arrow-left-dark")
        buttonBack.setImage(imgBack, for: .normal)
        
        let imgForward = webView.canGoForward ? UIImage(named: "arrow-right-yellow") : UIImage(named: "arrow-right-dark")
        buttonForward.setImage(imgForward, for: .normal)
    }
}
