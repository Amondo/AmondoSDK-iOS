//
//  InstagramVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/5/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension InstagramViewController {
    
    func prepareReusableViews() {
        tableViewComments.register(UINib(nibName: "CommentTableViewCell", bundle: Bundle(for: CommentTableViewCell.self)), forCellReuseIdentifier: "cellComment")
    }
    
    func prepareGestures() {
        let tapGestureClose = UITapGestureRecognizer(target: self, action: #selector(InstagramViewController.closeAnimation))
        tableViewComments.tableHeaderView!.addGestureRecognizer(tapGestureClose)
        
        let tapGestureLoad = UITapGestureRecognizer(target: self, action: #selector(InstagramViewController.initialAnimation))
        transitionImageView.addGestureRecognizer(tapGestureLoad)
        
        let gesturePan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(gesture:)))
        gesturePan.delegate = self
        tableViewComments.addGestureRecognizer(gesturePan)
    }
    
    func prepareUI() {
        let fileObject = asset.aobject?["file"] as? [String:Any]
        if let url = fileObject!["original_url"] as? String {
             
        } else {
            self.imageViewHero.contentMode = .scaleAspectFit
        }

        labelUsername.font = Fonts.sfSemiBold(size: 14)
        labelDate.font = Fonts.sfSemiBold(size: 10)
        labelText.font = Fonts.sfRegular(size: 16)
        
        let hasComments = asset.instagram!.comments.count > 0
        headerBackgroundView.backgroundColor = hasComments ? Colors.trueBlack : Colors.transparent
        
        if (UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688){
            //image stays in the position
        } else {
            //move image down because of rounder corners
            layoutConstraintImageViewFadeBottom.constant = -2;
            view.layoutIfNeeded()
        }
    }
    
    func prepareData() {
        labelUsername.text = asset.instagram!.username
        labelDate.text = "\(asset.instagram!.source!.uppercased()) • \((asset.date).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none).uppercased())"
        labelText.text = asset.instagram?.description
        
        if !Optional.isNil(asset.aobject!["avatar"]) {
            let file = AMDFile(file: asset.aobject!["avatar"] as! Dictionary<String, Any>, ftype: "photo")
            file.getDataInBackground { (error:Error?, data:Data?, cached:Bool) in
                if error == nil {
                    let img = UIImage(data: data!)
                    self.imageViewAvatar.image = img
                }
            }
        }
    }
    
}
