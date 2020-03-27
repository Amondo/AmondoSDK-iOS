//
//  ItemArticleVC+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension ItemArticleViewController {
    
    func prepareGestures() {
        let tapGestureClose = UITapGestureRecognizer(target: self, action: #selector(ItemVideoViewController.closeAnimation))
        viewWrapper.addGestureRecognizer(tapGestureClose)
        
        let gesturePanImage = UIPanGestureRecognizer(target: self, action: #selector(viewPannedPlayer(gesture:)))
        gesturePanImage.delegate = self
        viewImageWrapper.addGestureRecognizer(gesturePanImage)
    }
    
    func prepareUI() {
        buttonOpen.titleLabel?.font = Fonts.sfSemiBold(size: 15)
        viewImageWrapper.layer.cornerRadius = 10
        viewImageWrapper.layer.masksToBounds = true
        
        buttonOpen.layer.cornerRadius = 8
        buttonOpen.layer.borderWidth = 1
        buttonOpen.layer.borderColor = Colors.white.cgColor
    }
    
    func prepareData() {
        self.displayImage()
        self.transitionImageView.image = self.image
        self.imageViewCover.image = self.image
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.image = self.asset.coverImage
                self.imageViewCover.image = self.image
                self.transitionImageView.image = self.image
            }
        }
        
        transitionImageView.frame = initialFrame
        transitionImageView.contentMode = .scaleAspectFill
        transitionImageView.image = image
        transitionImageView.clipsToBounds = true
        transitionImageView.isUserInteractionEnabled = true
        self.view.addSubview(transitionImageView)
    }
    
}
