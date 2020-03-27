//
//  BrowserViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/14/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import WebKit

class BrowserViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewWebWrapper: UIView!
    var webView: WKWebView!
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var buttonForward: UIButton!
    
    var url: URL!
    
    static func instance() -> BrowserViewController {
        let vcInstance = BrowserViewController(nibName: "BrowserViewController", bundle: Bundle(for: BrowserViewController.self))
        vcInstance.modalTransitionStyle = .coverVertical
        vcInstance.modalPresentationStyle = .overCurrentContext
        return vcInstance
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareUI()
        prepareData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
