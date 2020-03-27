//
//  MediaUploadViewController+Actions.swift
//  Amondo
//
//  Created by developer@amondo.com on 6/15/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit

extension MediaUploadViewController {

    func uploadData() {
        updateProgress(percent: 0)

        uploadAssetsWithIds(totalProgress: { (progress:Double) in
            self.updateProgress(percent: progress * 0.95 + 1)
        }, uploadCompletion: { (success: Bool, _: AMDError?) in
            if success {
                self.updateProgress(percent: 100)
                AMDSharedImprints.saveShared(id: (self.imprintItem.event?.id)!)

                self.viewCompleteWrapper.isHidden = false
            } else {
                self.delegate?.uploadError()
            }
        })

        let eventID = self.imprintItem.event!.id!
        AMDUserAssetUploader.getEventSlug(event: eventID) { (_: AMDError?, slug: String?) in

            var newslug = AMDUserAssetUploader.randomSlugCreator(length: 10)
            if slug != nil {
                newslug = slug!
            }

            AMDUserAssetUploader.updateEventSlug(event: eventID, slug: newslug, completion: { (_: AMDError?, _: Bool) in

            })

        }
    }

    func uploadAssetsWithIds(totalProgress: @escaping (_ percent: Double) -> Void, uploadCompletion:@escaping (_ success: Bool, _ error: AMDError?) -> Void) {

        let id = Int(imprintItem.event!.id!)!

        var uploaded = 0
        var failed = 0

        var dataUploaded=[Double]()
        var totalData = [Double]()
        var ids = [String]()

        for item in selectedMedia {

            let itemID = item.asset!.localIdentifier
            let uploader = AMDUserAssetUploader(ass: item.asset!)

            uploader.getDataForAsset(completion: { (data: Data?, success: Bool) in

                let thisDataSize = Double(data!.count) / 1024

                dataUploaded.append(0)
                ids.append(itemID)
                totalData.append(thisDataSize)

                if success {
                    uploader.cloudinaryUpload(data: data!, eventID: id, tprogress: { (progress:Double) in
                        dataUploaded[ids.index(of: itemID)!]=progress
                        var u:Double = 0
                        var t:Double = 0
                        var ind = 0
                        for el in totalData {
                            u += totalData[ind]*dataUploaded[ind]
                            t += el
                            ind += 1
                        }
                        totalProgress(100 * (u / t))

                    }, completion: { (success: Bool, _: AMDError?) in
                        if success {
                            uploaded += 1
                        } else {
                            failed += 1
                        }

                        if uploaded + failed == self.selectedMedia.count {
                            if failed != 0 {
                                let aerror = AMDError(code: "400", errorString: "\(failed) items failed to upload", info: nil)
                                uploadCompletion(false, aerror)
                                return
                            } else {
                                uploadCompletion(true, nil)
                            }
                        }
                    })
                } else {
                    print("failed getting data for asset")
                    let aerror = AMDError(code: "400", errorString: "Couldn't read one of your images or videos", info: nil)
                    uploadCompletion(false, aerror)
                    return
                }
            })
        }

        if selectedMedia.count == uploaded {
            uploadCompletion(true, nil)
        }
    }

    func updateProgress(percent: Double) {
        self.labelProgress.text = "\(Int(percent))%"
    }

    @IBAction func actionShare() {
//        let imprintStoryboard: UIStoryboard = UIStoryboard(name: "Imprint", bundle: Bundle.main)
//        let vc = imprintStoryboard.instantiateViewController(withIdentifier: "ShareActionsVC") as! ShareActionsViewController
//        vc.currentImprint = self.imprintItem
//
//        self.present(vc, animated: false, completion: nil)
    }

    @IBAction func actionInvite() {

    }

    @IBAction func actionBack() {
        self.delegate?.backToImprint()
    }

}
