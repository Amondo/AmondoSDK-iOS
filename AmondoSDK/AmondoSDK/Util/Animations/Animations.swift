//
//  Animations.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/19/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import UIKit

class Animations: NSObject {

    class func addAmondoLogoAnimation(imageView: UIImageView) {
        var images = [UIImage]()
        for i in 2..<59 {
            if i < 10 {
                let strImageName: String = "amondo_logo_0000\(i).png"
                images.append(UIImage(named: strImageName)!)
            } else {
                let strImageName: String = "amondo_logo_000\(i).png"
                images.append(UIImage(named: strImageName)!)
            }
        }

        imageView.animationImages = images
        imageView.animationDuration = 2.0
    }
    
    class func addSwipeUpAnimation(imageView: UIImageView) {
        var images = [UIImage]()
        for i in 1..<45 {
            if i < 10 {
                let strImageName: String = "sw-up_0000\(i).png"
                images.append(UIImage(named: strImageName)!)
            } else {
                let strImageName: String = "sw-up_000\(i).png"
                images.append(UIImage(named: strImageName)!)
            }
        }
        
        imageView.animationImages = images
        imageView.animationDuration = 1.8
    }
    
    class func addSwipeDownAnimation(imageView: UIImageView) {
        var images = [UIImage]()
        for i in 1..<45 {
            if i < 10 {
                let strImageName: String = "sw-dwn_0000\(i).png"
                images.append(UIImage(named: strImageName)!)
            } else {
                let strImageName: String = "sw-dwn_000\(i).png"
                images.append(UIImage(named: strImageName)!)
            }
        }
        
        imageView.animationImages = images
        imageView.animationDuration = 1.8
    }

    class func addTapAnimation(imageView: UIImageView) {
        var images = [UIImage]()
        for i in 1..<45 {
            if i < 10 {
                let strImageName: String = "tap_0000\(i).png"
                images.append(UIImage(named: strImageName)!)
            } else {
                let strImageName: String = "tap_000\(i).png"
                images.append(UIImage(named: strImageName)!)
            }
        }
        
        imageView.animationImages = images
        imageView.animationDuration = 1.8
    }
}
