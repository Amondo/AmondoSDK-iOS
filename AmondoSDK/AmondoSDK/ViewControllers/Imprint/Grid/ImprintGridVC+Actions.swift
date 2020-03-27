//
//  ImprintGridVC+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/29/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

extension ImprintGridViewController {
    
    func openTile(tile: AMDAsset) {
        if collectionViewImprint.contentOffset.y < UIScreen.main.bounds.height-98 {
            UIView.animate(withDuration: 0.15, animations: {
                self.collectionViewImprint.contentOffset = CGPoint(x: 0, y: UIScreen.main.bounds.height-self.heightHeader)
            }) { (success) in
                self.showTile(tile: tile)
            }
        } else {
            self.showTile(tile: tile)
        }
    }
    
    func showTile(tile: AMDAsset) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "genericVC") as! TileDetailsViewController
        vc.asset = tile
        vc.gridStyle = gridStyle
        vc.imprint = imprint
        vc.delegate = self
        vc.heightHeader = heightHeader
        
        if tile.avPlayer != nil {
            vc.startTime = (tile.avPlayer!.currentTime())
            //vc.avPlayer = tile.avPlayer!
        }
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        navigationController?.present(vc, animated: true, completion: {
            
        })
    }
    
    @IBAction func actionMenu() {
        hideActionButtons()
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 1
        }
        self.performSegue(withIdentifier: "segueImprintActions", sender: nil)
    }
    
    @IBAction func actionContribute() {
        if PHPhotoLibrary.authorizationStatus() != .authorized || !(AMDUser.currentUser()?.photosPermitted ?? true)  {
            let vcPermissions = PermissionsViewController.instance(type: .camera)
            vcPermissions.delegate = self
            
            present(vcPermissions, animated: true) {
            }
        } else {
            let galleryMedia = imprint.populateSectionsForImprintNew()
            if galleryMedia.count > 0 {
                let story: UIStoryboard = UIStoryboard(name: "Contribute", bundle: Bundle(for: SelectMediaViewController.self))
                let vc = story.instantiateInitialViewController() as! SelectMediaViewController
                vc.delegate = self
                vc.imprintItem = imprint
                
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
    
    func animateUpload() {
        viewNotification = NotificationService.showNotification(view: self.labelUploading, text: "It will take couple of moments to upload your content.", emoji: "🐝", backgroundColor: UIColor.Notification.info, textColor: UIColor.Notification.infoText, paddingConstant: 20.0, padding: .bottom)
        viewNotification?.dismissable = false
        
        Animations.addAmondoLogoAnimation(imageView: imageViewUploadLoader)
        imageViewUploadLoader.startAnimating()
        
    }
    
    func showUploadCompleted() {
        imageViewUploadLoader.stopAnimating()
        if layoutConstraintImprintWrapperBottom.constant != 0 {
            imageViewUploadLoader.image = UIImage(named: "logo-mono")
            labelUploading.text = "🎉 Uploaded 🎉"
            viewNotification = NotificationService.showNotification(view: self.labelUploading, text: "Your content is uploaded and is awaiting for moderation.", emoji: "🙌", backgroundColor: UIColor.Notification.positive, textColor: UIColor.Notification.positiveText, paddingConstant: 20.0, padding: .bottom)
            viewNotification?.dismissable = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.closeUpload()
            }
        } else {
            viewNotification = NotificationService.showNotification(view: self.viewContributeWrapper, text: "Your content is uploaded and is awaiting for moderation.", emoji: "🙌", backgroundColor: UIColor.Notification.positive, textColor: UIColor.Notification.positiveText, paddingConstant: 20.0, padding: .top)
            
            UIView.animate(withDuration: 0.2, animations: {
                self.labelUploadClock.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.labelUploadClock.layer.removeAllAnimations()
            }) { (success) in
                self.labelUploadClock.isHidden = true
                self.buttonContribute.isHidden = false
                UIView.animate(withDuration: 0.2, animations: {
                    self.buttonContribute.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
        }
    }
    
    func showUploadError() {
        imageViewUploadLoader.stopAnimating()
        if layoutConstraintImprintWrapperBottom.constant != 0 {
            imageViewUploadLoader.image = UIImage(named: "logo-mono")
            labelUploading.text = "Error Occured"
            viewNotification = NotificationService.showNotification(view: self.labelUploading, text: "There was a error while uploading the content, please try agian.", emoji: "🙌", backgroundColor: UIColor.Notification.negative, textColor: UIColor.Notification.negativeText, paddingConstant: 20.0, padding: .bottom)
            viewNotification?.dismissable = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.closeUpload()
            }
        } else {
            viewNotification = NotificationService.showNotification(view: self.viewContributeWrapper, text: "There was a error while uploading the content, please try agian.", emoji: "🙌", backgroundColor: UIColor.Notification.negative, textColor: UIColor.Notification.negativeText, paddingConstant: 20.0, padding: .top)
        }
    }
    
    func closeUpload() {
        showActionButtons()
        layoutConstraintImprintWrapperBottom.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        }) { (success) in
            self.viewUploadWrapper.isHidden = true
        }
    }
    
    func showActionButtons() {
        viewMenuWrapper.alpha = 1
        viewContributeWrapper.alpha = 0

        if UploadManager.instance.uploadInProgress {
            if !buttonContribute.isHidden {
                UIView.animate(withDuration: 0.2, animations: {
                    self.buttonContribute.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                }) { (success) in
                    self.labelUploadClock.isHidden = false
                    self.buttonContribute.isHidden = true
                    UIView.animate(withDuration: 0.2, animations: {
                        self.labelUploadClock.transform = CGAffineTransform(scaleX: 1, y: 1)
                    }) { (success) in
                        let rotation = CASpringAnimation(keyPath: "transform.rotation.z")
                        rotation.damping = 10.0
                        rotation.fromValue = 0.0
                        rotation.toValue = Float.pi
                        rotation.duration = 1
                        rotation.repeatCount = Float.infinity
                        self.labelUploadClock.layer.add(rotation, forKey: "rotation")
                    }
                }
            }
        } else {
            self.labelUploadClock.isHidden = true
            self.buttonContribute.isHidden = false
            UIView.animate(withDuration: 0.2, animations: {
                self.buttonContribute.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }
    }
    
    func hideActionButtons() {
        viewMenuWrapper.alpha = 0
        viewContributeWrapper.alpha = 0
    }
    
    func showFinito(animated:Bool) {
        //disable finitio for SDK
        return;
        UIView.animate(withDuration: 0.3) {
            self.visualEffectViewBlurOverview.alpha = 1
        }
        let vcFinito = FinitoViewController.instance()
        vcFinito.delegate = self
        vcFinito.currentImprint = imprint
        
        self.present(vcFinito, animated: animated) {
        }
    }
    
}
