//
//  ImageCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 08/09/2016.
//  Copyright © 2016 Amondo. All rights reserved.
//

import Photos
import UIKit
import Alamofire

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var blur: UIVisualEffectView!
    var indexPath: IndexPath!
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    var asset: PHAsset? {
        didSet {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            
            imageView.image = nil
            
            manager.requestImage(for: self.asset!, targetSize: self.frame.size, contentMode: .aspectFill, options: option, resultHandler: {result, _ -> Void in
                self.imageView.image = result!
            })
        }
    }
    
    func displayImageWithDownload(item: AMDAsset, indexPath: IndexPath, vcView: UIView, completion:@escaping (_ imLoad: Bool, _ success: Bool) -> Void) -> DataRequest? {
        
        self.indexPath = indexPath
        
        if item.coverImage != nil {
            self.imageView.image = item.coverImage
        } else {
            
        }
        
        if item.cacheState == "small" {
            self.blur.alpha = 1
            
            if item.loading == false {
                item.loading = true
                let file = AMDFile(file: item.aobject!["file"] as! Dictionary<String, Any>, ftype: "photo")
                
                file.width = Int(vcView.bounds.width)
                file.height = Int(vcView.bounds.height)
                file.cacheUrl = file.cacheURLConstructor()
                file.cached = file.checkDoesCacheExist()
                print(file.parsedURL())
                
                let r = file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
                    
                    item.loading = false
                    
                    if error == nil {
                        
                        if let resim = UIImage(data: data!) {
                            item.cacheState = "full"
                            item.coverImage = resim
                            completion(true, true)
                            if self.indexPath == indexPath {
                                self.imageView.image = item.coverImage
                                UIView.animate(withDuration: 0.3, animations: {
                                    self.blur.alpha = 0
                                })
                            }
                            return
                        }
                        
                    }
                    
                    completion(true, false)
                    
                })
                return r
            }
        } else {
            self.blur.alpha = 0
            completion(false, true)
        }
        return nil
    }
}
