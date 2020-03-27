//
//  SelectMediaViewController+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import AssetsLibrary
import Photos

extension SelectMediaViewController {
    
    func prepareCells() {
        collectionViewMedia.register(UINib(nibName: "ContributeMediaCollectionViewCell", bundle: Bundle(for: ContributeMediaCollectionViewCell.self)), forCellWithReuseIdentifier: "cellContributeMedia")
    }

    func prepareData() {
        checkAuthorizationForPhotoLibraryAndGet()
    }

    func prepareGfx() {
        Animations.addAmondoLogoAnimation(imageView: imageViewLoader)
        buttonContribute.layer.cornerRadius = 8
        buttonContribute.titleLabel?.font = Fonts.sfSemiBold(size: 15)
        labelLoadingTitle.font = Fonts.sfSemiBold(size: 14)
        buttonGoBack.titleLabel?.font = Fonts.sfRegular(size: 16)
        if selectedMedia.count > 0 {
            buttonContribute.setTitle("(\(selectedMedia.count)) Upload →", for: .normal)
            labelContributeCount.text = "Upload (\(selectedMedia.count))"
        } else {
            buttonContribute.setTitle("", for: .normal)
            labelContributeCount.text = ""
        }
        labelContributeCount?.font = Fonts.sfSemiBold(size: 15)
        if selectedMedia.count > 0 {
            imageViewFade.isHidden = false
            viewSelectedMediaWrapper.isHidden = false
            collectionViewMedia.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 58, right: 0)
        } else {
            imageViewFade.isHidden = true
            viewSelectedMediaWrapper.isHidden = true
            collectionViewMedia.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        navigationBarView.delegate = self
        navigationBarView.labelTitle.text = "Contribute"
    }

    func loadGalleryMedia() {
        viewLoadingWrapper.isHidden = false
        imageViewLoader.startAnimating()
        labelLoadingTitle.styleHeading(text: "CHECKING")
        labelLoadingDescription.textColor = Colors.silverChalice
        labelLoadingDescription.text = "One moment, looking for the content from this event on your phone."
        labelLoadingTitleLeft.text = "🔍"
        labelLoadingTitleRight.text = "🔎"
        buttonGoBack.setTitle("Go Back", for: .normal)
        galleryMedia = imprintItem.populateSectionsForImprintNew()
        if galleryMedia.count > 0 {
            imageViewLoader.stopAnimating()
            collectionViewMedia.reloadData()
            viewLoadingWrapper.isHidden = true
        } else {
            layoutConstraintDescriptionTop.priority = UILayoutPriority(rawValue: 250)
            layoutConstraintDescriptionCenter.priority = UILayoutPriority(rawValue: 750)
            view.layoutIfNeeded()
            imageViewLoader.stopAnimating()
            labelLoadingTitle.text = ""
            //labelLoadingTitle.styleHeading(text: "EMPTY")
            labelLoadingDescription.textColor = Colors.silverChalice
            labelLoadingDescription.text = "You don’t have any photos or videos that match the dates of this event."
            labelLoadingTitleLeft.text = ""
            labelLoadingTitleRight.text = ""
            buttonGoBack.setTitle("Go Back", for: .normal)
        }
    }

    private func checkAuthorizationForPhotoLibraryAndGet() {
        let status = PHPhotoLibrary.authorizationStatus()

        if (status == PHAuthorizationStatus.authorized) {
            self.loadGalleryMedia()
        } else {
            PHPhotoLibrary.requestAuthorization({ newStatus in
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.loadGalleryMedia()
                } else {

                }
            })
        }
    }

}
