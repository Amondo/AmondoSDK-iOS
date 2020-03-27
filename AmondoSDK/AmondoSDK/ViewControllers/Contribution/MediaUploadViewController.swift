//
//  MediaUploadViewController.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

class MediaUploadViewController: UIViewController {

    // MARK: - UI

    @IBOutlet weak var viewInProgressWrapper: UIView!
    @IBOutlet weak var viewCompleteWrapper: UIView!
    @IBOutlet weak var imageViewHero: UIImageView!
    @IBOutlet weak var labelProgress: UILabel!
    @IBOutlet weak var labelUploaded: UILabel!
    @IBOutlet weak var labelReviewing: UILabel!
    @IBOutlet weak var labelReviewingInfo: UILabel!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var buttonBack: UIButton!

    var imprintItem: AMDImprintItem!
    var selectedMedia: Array<AMDAsset> = []
    weak var delegate: MediaUploadViewControllerDelegate?

    // MARK: - Base Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareGfx()
        prepareData()
    }

}
