//
//  ImprintGridViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/15/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class ImprintGridViewController: UIViewController {
    
    @IBOutlet var collectionViewImprint: UICollectionView!
    @IBOutlet weak var viewMenuWrapper: UIView!
    @IBOutlet weak var buttonContribute: UIView!
    @IBOutlet weak var viewContributeWrapper: UIView!
    
    @IBOutlet weak var labelUploadClock: UILabel!
    @IBOutlet weak var viewUploadWrapper: UIView!
    @IBOutlet weak var labelSwipeDownUpload: UILabel!
    @IBOutlet weak var labelUploading: UILabel!
    @IBOutlet weak var imageViewUploadLoader: UIImageView!
    @IBOutlet weak var visualEffectViewBlurOverview: UIVisualEffectView!
    
    @IBOutlet weak var layoutConstraintImprintWrapperBottom: NSLayoutConstraint!
    
    var viewNotification: NotificationView?
    
    var gesturePan:UIPanGestureRecognizer!
    var gestureSwipe:UISwipeGestureRecognizer!
    
    var imprint: AMDImprintItem!
    var isSquare: Bool = false
    var lastRow: Int = -1
    var lastHeight: CGFloat = 0
    var activeDownloads = [DataRequest]()
    var loadingItems = false
    var headerGrid: GridHeaderReusableView?
    var heightTotal: CGFloat!
    var heightHeader: CGFloat = 110
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGfx()
        prepareReusableViews()
        prepareGestures()
        prepareData()
        prepareObservers()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UploadManager.instance.delegate = self
    }
    
    @objc func closeImprint() {
        for req in activeDownloads {
            req.cancel()
        }
        IMPRINTVC?.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ImprintClose") , object: nil)
    }
}
