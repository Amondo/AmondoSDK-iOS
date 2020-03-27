//
//  SelectMediaViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos

class SelectMediaViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var navigationBarView: NavigationBarView!
    @IBOutlet weak var imageViewLoader: UIImageView!
    @IBOutlet weak var viewLoadingWrapper: UIView!
    @IBOutlet weak var labelLoadingTitleLeft: UILabel!
    @IBOutlet weak var labelLoadingTitleRight: UILabel!
    @IBOutlet weak var labelLoadingTitle: UILabel!
    @IBOutlet weak var labelLoadingDescription: UILabel!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var labelContributeCount: UILabel!
    
    @IBOutlet weak var collectionViewMedia: UICollectionView!
    @IBOutlet weak var imageViewFade: UIImageView!
    @IBOutlet weak var viewSelectedMediaWrapper: UIView!
    @IBOutlet weak var buttonContribute: UIButton!

    // MARK: - Variables

    var delegate: SelectMediaViewControllerDelegate?
    var imprintItem: AMDImprintItem!
    var galleryMedia: Array<AMDAsset> = []
    var selectedMedia: Array<AMDAsset> = []
    
    @IBOutlet weak var layoutConstraintDescriptionCenter: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintDescriptionTop: NSLayoutConstraint!
    // MARK: - Base Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCells()
        prepareGfx()
        prepareData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MediaUploadViewController {
            controller.imprintItem = imprintItem
            controller.delegate = self
            controller.selectedMedia = selectedMedia
        }
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
