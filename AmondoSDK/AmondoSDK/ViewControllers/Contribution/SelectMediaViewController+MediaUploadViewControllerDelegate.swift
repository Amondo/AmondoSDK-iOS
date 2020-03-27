//
//  SelectMediaViewController+MediaUploadViewControllerDelegate.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/18/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation

extension SelectMediaViewController: MediaUploadViewControllerDelegate {

    func backToImprint() {
        navigationController?.dismiss(animated: false, completion: {
            self.navigationController?.popViewController(animated: true)
        })
    }

    func uploadError() {
        navigationController?.dismiss(animated: true, completion: {
            self.viewLoadingWrapper.isHidden = false
            self.labelLoadingTitle.styleHeading(text: "OOOOOPS")
            self.labelLoadingDescription.text = "😳 Something went wrong 😳"
            self.labelLoadingDescription.textColor = Colors.yellow
            self.labelLoadingTitleLeft.text = "💥"
            self.labelLoadingTitleRight.text = "💥"
            self.buttonGoBack.setTitle("Try Again?", for: .normal)
        })
    }

}
