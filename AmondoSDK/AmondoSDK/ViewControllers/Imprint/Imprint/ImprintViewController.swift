//
//  ImprintViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/27/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI
import Photos

func getIgnoreAssets(_ event:String) -> [String] {
    let assets = UserDefaults.standard.value(forKey: "IGNORE_ASSETS-\(event)") as? [String]
    if assets == nil {
        setIgnoreAssets(event, assetIds: [])
        return []
    } else {
        return assets!
    }
}

func setIgnoreAssets(_ event:String,assetIds:[String]){
    UserDefaults.standard.setValue(assetIds, forKey: "IGNORE_ASSETS-\(event)")
}

var IMPRINTVC: ImprintGridViewController?
var IMPRINTVCNAV: UINavigationController?

class ImprintViewController: UIViewController {
    
    @IBOutlet weak var viewImprintWrapper: UIView!
    @IBOutlet weak var collectionViewAssets: UICollectionView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var alertBlob: UIView!
    @IBOutlet var pageControlAssets: ISPageControl!
    @IBOutlet weak var svLeftView: NSLayoutConstraint!
    @IBOutlet weak var svRightView: NSLayoutConstraint!
    @IBOutlet weak var visualEffectViewBlurOverview: UIVisualEffectView!
    @IBOutlet weak var buttonMenu: UIButton!
    @IBOutlet weak var visualEffectViewBlurMenu: UIVisualEffectView!
    @IBOutlet weak var buttonContribute: UIButton!
    @IBOutlet weak var visualEffectViewBlurContribute: UIVisualEffectView!
    @IBOutlet weak var labelUploadClock: UILabel!
    
    @IBOutlet weak var viewUploadWrapper: UIView!
    @IBOutlet weak var labelSwipeDownUpload: UILabel!
    @IBOutlet weak var labelUploading: UILabel!
    @IBOutlet weak var imageViewUploadLoader: UIImageView!
    
    @IBOutlet weak var viewPageControllerWrapper: UIView!
    var pageViewControllerTiles: UIPageViewController?
    @IBOutlet weak var layoutConstraintImprintWrapperBottom: NSLayoutConstraint!
    
    var viewNotification: NotificationView?
    
    var layoutConfigs: NSDictionary?
    var currentSection = 0
    var navigationDirection: Direction?
    var transitionLayout: UICollectionViewTransitionLayout?
    var transitionInProgress = false
    var finalLayout: ImprintLayout?
    var dontTransition = false
    var uploadOpen = false
    
    var assets = [AMDAsset]()
    var sections = [[AMDAsset]]()
    var sectionAssets = [AMDAsset]()
    let damping:CGFloat = 1
    var initialFrames = [CGRect]()
    var selectedCell:IndexPath?
    var selectedItem:NSInteger = 0
    var currentImprint: AMDImprintItem!
    var phmanager: PHImageManager?
    var cellViews = [[UICollectionViewCell]]()
    var changedTransIm = false
    var gestInProcess = false
    var swipeInProcess = false
    var endVc: FinitoViewController!
    var scrollScale:CGFloat=0
    var isDragging = false
    var imprintLayout = ImprintLayout()
    var transitionCell: EventCollectionViewCell!
    var transFrame:CGRect!
    var artistFrame:CGRect?
    var artistFont:UIFont?
    var activeDownloads = [DataRequest]()
    var loadingItems=false
    var viewPan:UIPanGestureRecognizer!
    var viewSwipe:UISwipeGestureRecognizer!
    var bottomSpaceLayout:CGFloat = 0
    var viewControllerAssetDetail: UIViewController?
    var menuPanGesture = UIPanGestureRecognizer()
    var menuTap = UITapGestureRecognizer()
    var finitoPanGesture = UIPanGestureRecognizer()
    var finitoTap = UITapGestureRecognizer()
    var isMenuOpen: Bool = false
    var firstTime = true
    var shouldShowTutorialContribute = false
    
    func orientationLabels(fromSection section: Int) -> [String] {
        let amdAssets = sections[section]
        var orientationLabels = [String]()
        for amdAsset in amdAssets {
            orientationLabels.append(amdAsset.orientationLabel)
        }
        
        return orientationLabels
    }
    
    
    fileprivate var contentHeight: CGFloat {
        return collectionViewAssets!.bounds.height
    }
    
    fileprivate var contentWidth: CGFloat {
        return collectionViewAssets!.bounds.width
    }
    
    func setInitialLayout() -> ImprintLayout {
        
        let initialLayout = ImprintLayout()
        initialLayout.delegate = self
        self.collectionViewAssets!.collectionViewLayout = initialLayout
        return initialLayout
    }
    
    func setFinalLayout() -> ImprintLayout {
        
        finalLayout = ImprintLayout()
        finalLayout?.delegate = self
        finalLayout?.currentSection = nextSection()
        return finalLayout!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ImprintActionsViewController {
            if segue.identifier == "segueImprintShare" {
                vc.isJustShare = true
            }
            vc.imprint = currentImprint
            vc.delegate = self
        }
        if let vc = segue.destination as? UIPageViewController {
            self.pageViewControllerTiles = vc
            self.pageViewControllerTiles?.delegate = self
            self.pageViewControllerTiles?.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareReusableViews()
        prepareObservers()
        prepareGestures()
        prepareData()
        prepareImprintLayout()
    }
    
    var isHiddenAllowed:Bool = false{
        didSet{
            UIView.animate(withDuration: 0.3, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            }) { (done) in
                self.collectionViewAssets.contentInset.top = 0
                self.collectionViewAssets.contentOffset.y = 0
            }
        }
    }
    
    func playCover(){
        currentImprint.avPlayer?.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UploadManager.instance.delegate = self
        if firstTime {
            self.collectionViewAssets.contentInset.top = 0
            self.collectionViewAssets.contentOffset.y = 0
        }
    }
    
    func storeIgnoreItems(){
        var ids = [String]()
        for el in currentImprint.deviceAssets {
            if el.2 == false {
                ids.append(el.0.asset!.localIdentifier)
            }
        }
        
        
        setIgnoreAssets(currentImprint.event!.id, assetIds: ids)
    }
    
    
    func triggerEnd(){
        self.view.bringSubviewToFront(self.pageControlAssets)
        UIView.animate(withDuration: 0.3, animations: {
            self.pageControlAssets.alpha = 0
            self.visualEffectViewBlurOverview.alpha = 0
        })
    }
    
    @objc func menuPan(_ gesture:UIPanGestureRecognizer){
        if gesture.state == .began {
            if gesture.direction == .Down {
                actionCloseMenu()
            }
        }
    }
    
    @objc//should rename and refactor
    @IBAction func actionCloseMenu(){
        self.buttonMenu.alpha = 1
        self.visualEffectViewBlurMenu.alpha = 1
        self.buttonContribute.alpha = 1
        self.visualEffectViewBlurContribute.alpha = 1
        isMenuOpen = false
        collectionViewAssets.isUserInteractionEnabled = true
        self.view.removeGestureRecognizer(menuPanGesture)
        self.view.removeGestureRecognizer(menuTap)
    
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.collectionViewAssets.alpha = 1
            self.visualEffectViewBlurOverview.alpha = 0
            self.pageControlAssets.alpha = 1
            self.pageControlAssets.center.y = self.collectionViewAssets.center.y
        }) { (done) in
            
        }
    }
    
    @IBAction func actionMenu(_ sender: AnyObject) {
        isMenuOpen = true
        
        menuPanGesture = UIPanGestureRecognizer(target: self, action: #selector(menuPan(_:)))
        menuTap = UITapGestureRecognizer(target: self, action: #selector(actionCloseMenu))
        
        self.view.addGestureRecognizer(menuPanGesture)
        self.view.addGestureRecognizer(menuTap)
        
        collectionViewAssets.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.pageControlAssets.alpha = 0
            self.visualEffectViewBlurOverview.alpha = 1
            self.collectionViewAssets.alpha = 0.5
            self.pageControlAssets.center.y = self.collectionViewAssets.center.y
        })
        
        self.performSegue(withIdentifier: "segueImprintActions", sender: nil)
    }
    
    @IBAction func actionContribute() {
        if PHPhotoLibrary.authorizationStatus() != .authorized || !(AMDUser.currentUser()?.photosPermitted ?? true)  {
            let vcPermissions = PermissionsViewController.instance(type: .camera)
            vcPermissions.delegate = self
            
            present(vcPermissions, animated: true) {
            }
        } else {
            let galleryMedia = currentImprint.populateSectionsForImprintNew()
            if galleryMedia.count > 0 {
                let story: UIStoryboard = UIStoryboard(name: "Contribute", bundle: Bundle.main)
                let vc = story.instantiateInitialViewController() as! SelectMediaViewController
                vc.delegate = self
                vc.imprintItem = currentImprint
                
                navigationController?.pushViewController(vc, animated: true)
            } else {
                let vcPermissions = PermissionsViewController.instance(type: .camera)
                vcPermissions.delegate = self
                vcPermissions.noMedia = true
                
                present(vcPermissions, animated: true) {
                }
            }
        }
    }
    
    @IBAction func invite(_ sender: AnyObject) {
        //TODO message composer
    }
    
    override func viewWillLayoutSubviews() {
        if firstTime {
            self.collectionViewAssets.contentInset.top = 0
            self.collectionViewAssets.contentOffset.y = 0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            collectionViewAssets.contentInset.top = -collectionViewAssets.safeAreaInsets.top
        } else {
            // Fallback on earlier versions
        }
        playVideos()
        // TEMP;TODO STILL NOT SURE IF WE NEED TO REMOVE IT
//        UIView.animate(withDuration: 0.3) {
//            self.collectionViewAssets.contentOffset.y=CGFloat(self.currentSection)*self.view.bounds.height
//        }
        
        if firstTime {
            self.collectionViewAssets.contentInset.top = 0
            self.collectionViewAssets.contentOffset.y = 0
        }

        firstTime = false
    }
    
    func hideAlert(){
        self.view.bringSubviewToFront(alertView)
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alertView.alpha = 0
            self.alertBlob.center.y = 1.5*self.view.bounds.height
        }) { (b:Bool) in
            self.view.sendSubviewToBack(self.alertView)
            self.alertView.alpha = 0
        }
    }
    
    @IBAction func gotIt(_ sender: AnyObject) {
        
        UserDefaults.standard.setValue(true, forKey: "SeenTips")
        hideAlert()
    }
    
    func showAlert(){
        self.view.bringSubviewToFront(alertView)
        alertView.alpha=0
        alertBlob.center.y = 1.5*self.view.bounds.height
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alertView.alpha=1
            self.alertBlob.center.y = self.view.center.y
        }) { (b:Bool) in
            
        }
    }
    
    @IBOutlet weak var alertView2: UIView!
    @IBOutlet weak var alertBlob2: UIView!
    
    func hideAlert2(){
        self.view.bringSubviewToFront(alertView)
        
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alertView2.alpha=0
            self.alertBlob2.center.y = 1.5*self.view.bounds.height
        }) { (b:Bool) in
            self.view.sendSubviewToBack(self.alertView2)
            self.alertView2.alpha=0
        }
    }
    
    @IBAction func gotIt2(_ sender: AnyObject) {
        UserDefaults.standard.setValue(true, forKey: "SeenEditTipsNew")
        hideAlert2()
    }
    
    func showAlert2(){
        self.view.bringSubviewToFront(alertView2)
        alertView2.alpha=0
        alertBlob2.center.y=1.5*self.view.bounds.height
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alertView2.alpha=1
            self.alertBlob2.center.y = self.view.center.y
        }) { (b:Bool) in
            
        }
    }
    
    func showButtonPress1(_ sender:UIButton){
        //TODO
        performSegue(withIdentifier: "oops", sender: self)
    }
    
    func showButtonPress2(_ sender:UIButton){
        //TODO
        performSegue(withIdentifier: "oops", sender: self)
    }
    
    
    override var prefersStatusBarHidden : Bool {
        if isHiddenAllowed == false {
            return false
        }
        
        var iphoneX = false
        if #available(iOS 11.0, *) {
            if ((UIApplication.shared.keyWindow?.safeAreaInsets.top)! > CGFloat(0.0)) {
                iphoneX = true
            }
        }
        return !iphoneX
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func stringFromTimeInterval(_ interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        
        let str = String(format: "%02d:%02d", minutes, seconds)
        return str
    }
    
}
