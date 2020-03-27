//
//  TutorialViewController+Prepare.swift
//  Amondo
//
//  Created by developer@amondo.com on 10/3/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension TutorialViewController {
    
    func prepareGestures() {
        switch step! {
        case .exploreImprint:
            let gestureSwipeUp = UISwipeGestureRecognizer(target: self, action: #selector(gestureTaken)) as UISwipeGestureRecognizer
            gestureSwipeUp.direction = .up
            viewWrapper.addGestureRecognizer(gestureSwipeUp)
        case .openTile:
            let gestureTap = UITapGestureRecognizer(target: self, action: #selector(gestureTaken)) as UITapGestureRecognizer
            gestureTap.numberOfTapsRequired = 1
            viewWrapper.addGestureRecognizer(gestureTap)
        case .closeTile:
            let gestureSwipeDown = UISwipeGestureRecognizer(target: self, action: #selector(gestureTaken)) as UISwipeGestureRecognizer
            gestureSwipeDown.direction = .down
            viewWrapper.addGestureRecognizer(gestureSwipeDown)
        default:
            return ()
        }
    }
    
    func prepareData() {
        switch step! {
        case .exploreImprint:
            labelBoxEmoji.text = "🌈"
            labelDescription.text = "This is an Imprint, a collection of the best content from an event. First, swipe to explore."
            Animations.addSwipeUpAnimation(imageView: imageViewHand)
            imageViewHand.startAnimating()
        case .openTile:
            labelBoxEmoji.text = "⚡️"
            labelDescription.text = "Nice! Now tap on a tile to view the content in more detail."
            Animations.addTapAnimation(imageView: imageViewHand)
            imageViewHand.startAnimating()
        case .closeTile:
            labelBoxEmoji.text = "🍭"
            labelDescription.text = "Great work. Now swipe down on the content to get back to the Imprint."
            Animations.addSwipeDownAnimation(imageView: imageViewHand)
            imageViewHand.startAnimating()
        case .contribute:
            labelBoxEmoji.text = "🔮"
            labelDescription.text = "To submit your own photos and videos to the Public Imprint, tap on the plus icon."
        }
    }
    
    func prepareUI() {
        buttonContribute.layer.cornerRadius = 32
        labelDescription.font = Fonts.sfRegular(size: 14)
        labelDescription.textColor = Colors.trueBlack
        viewBox.layer.cornerRadius = 8
        viewBox.layer.masksToBounds = true
        viewBox.clipsToBounds = true
        viewContribute.isHidden = step != .contribute
        if step == .contribute {
            layoutConstraintBoxBottom.priority = UILayoutPriority(rawValue: 250)
            layoutConstraintContributeBottom.priority = UILayoutPriority(rawValue: 750)
        } else {
            layoutConstraintBoxBottom.priority = UILayoutPriority(rawValue: 750)
            layoutConstraintContributeBottom.priority = UILayoutPriority(rawValue: 250)
        }
    }
    
}
