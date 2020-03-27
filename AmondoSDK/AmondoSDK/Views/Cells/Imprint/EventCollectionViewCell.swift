//
//  GridCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/20/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    // MARK: - UI

    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var viewImageWrapper: UIView!
    @IBOutlet weak var viewImageGradientWrapper: UIView!
    @IBOutlet weak var imageViewArtist: UIImageView!
    @IBOutlet weak var labelLocationDate: UILabel!
    @IBOutlet weak var labelArtist: UILabel!
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var viewActionBlurView: UIView!
    @IBOutlet weak var buttonAction: UIButton!
    @IBOutlet weak var labelIndicator: UILabel!
    @IBOutlet weak var viewLoader: UIView!
    @IBOutlet weak var imageViewLoader: UIImageView!
    @IBOutlet weak var layoutConstraintInfoViewBottom: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintFavouriteButtonTop: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintTitleLocationDateBottom: NSLayoutConstraint!
    
    @IBOutlet weak var layoutConstraintActionTopSafe: NSLayoutConstraint!
    @IBOutlet weak var layoutConstraintActionTopSuper: NSLayoutConstraint!
    // MARK: - Variables

    var indexPath: IndexPath!
    var item: AMDImprintItem!

    // MARK: - Base Functions

    override func prepareForReuse() {
        super.prepareForReuse()
        removeImage()
    }

    // MARK: - Cell Functions

    func removeImage() {
        imageViewArtist.image = nil
        imageViewArtist.alpha = 0
    }

    func adjustToGridView() {
        labelArtist.numberOfLines = 2
        labelArtist.minimumScaleFactor = 0.5
        labelArtist.font = Fonts.condensedBoldWithSize(size: 18)
        labelLocationDate.font = Fonts.sfSemiBold(size: 10)
        layoutConstraintTitleLocationDateBottom.constant = 2
    }

    func startLoader() {
        viewLoader.isHidden = false
        Animations.addAmondoLogoAnimation(imageView: imageViewLoader)
        imageViewLoader.startAnimating()
    }

    func stopLoader() {
        imageViewLoader.stopAnimating()
        viewLoader.isHidden = true
    }
}
