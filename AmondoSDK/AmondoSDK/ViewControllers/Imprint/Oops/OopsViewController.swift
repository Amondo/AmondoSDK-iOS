//
//  OopsViewController.swift
//  Amondo
//
//  Created by Timothy Whiting on 18/11/2016.
//  Copyright © 2016 Arcopo. All rights reserved.
//

import UIKit

extension UIViewController {
    func addDragDownToDismiss() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(screenPan(gesture:)))
        self.view.addGestureRecognizer(pan)
    }
    @objc func screenPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .ended {
            if self.view.frame.origin.y > 80 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin.y = 0
                })
            }
        } else {
            self.view.frame.origin.y = self.view.frame.origin.y + gesture.translation(in: self.view).y / 2
            if self.view.frame.origin.y < 0 {
                self.view.frame.origin.y = 0
            }
        }
        gesture.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
    }
}

class OopsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.addDragDownToDismiss()
    }

    @IBAction func back(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

    var notified = false

    @IBAction func notifyMe(_ sender: AnyObject) {

        if notified {
            self.dismiss(animated: true, completion: nil)
            return
        }

        notified = true
        (sender as! UIButton).setTitle("Notification set!", for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.isHiddenAllowed = true
    }

    var isHiddenAllowed: Bool = false {
        didSet {

            UIView.animate(withDuration: 0.3, animations: {
                self.setNeedsStatusBarAppearanceUpdate()

            }) { _ in

            }

        }
    }

    override var prefersStatusBarHidden: Bool {
        if isHiddenAllowed == false {
            return true
        }
        return false
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
