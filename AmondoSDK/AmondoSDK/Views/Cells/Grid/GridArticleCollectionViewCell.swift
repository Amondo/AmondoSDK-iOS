//
//  ArticleCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 12/17/18.
//  Copyright © 2018 Amondo. All rights reserved.
//

import UIKit
import Alamofire

class GridArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var blur: UIVisualEffectView!
    var indexPath: IndexPath!
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    func displayImageWithDownload(item: AMDAsset, indexPath: IndexPath, vcView: UIView, completion:@escaping (_ imLoad: Bool, _ success: Bool) -> Void) -> DataRequest? {
        
        self.indexPath = indexPath
        viewWrapper.backgroundColor = gridStyle.tileBackgroundColor
        
        if item.coverImage != nil {
            self.imageViewCover.image = item.coverImage
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
                                self.imageViewCover.image = item.coverImage
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
