//
//  GridImageCollectionViewCell.swift
//  Amondo
//
//  Created by developer@amondo.com on 4/22/18.
//  Copyright © 2019 Amondo. All rights reserved.
//

import UIKit
import Photos
import Alamofire

class GridImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewWrapper: UIView!
    @IBOutlet weak var imageViewGridItem: UIImageView!
    @IBOutlet weak var imageViewLogo: UIImageView!
    @IBOutlet weak var visualEffectViewBlur: UIVisualEffectView!
    
    var item: AMDAsset!
    var indexPath: IndexPath!
    var gridStyle: ImprintGridStyle = ImprintGridStyle()
    
    var asset: PHAsset? {
        didSet {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            self.imageViewGridItem.image = nil
            
            manager.requestImage(for: self.asset!, targetSize: self.frame.size, contentMode: .aspectFill, options: option, resultHandler: {result, _ -> Void in
                self.imageViewGridItem.image = result!
            })
        }
    }
    
    func prepareCell(indexPath:IndexPath) {
        self.indexPath = indexPath;
        if self.item.coverImage != nil && self.item.cacheState == "full" {
            self.imageViewGridItem.image = item.coverImage
        }
        
        viewWrapper.backgroundColor = gridStyle.tileBackgroundColor
        
        if self.item.cacheState == "small" {
            item.loading = false
            self.visualEffectViewBlur.alpha = 1
            
            if item.loading == false {
                item.loading = true
                let file = AMDFile(file: item.aobject!["file"] as! Dictionary<String, Any>, ftype: "photo")
                
                file.width = Int(UIScreen.main.bounds.width)
                file.height = Int(UIScreen.main.bounds.height)
                file.cacheUrl = file.cacheURLConstructor()
                file.cached = file.checkDoesCacheExist()
                if let cover = self.item.coverImage {
                    file.cached = false
                    file.cacheUrl = nil
                }
                print(file.parsedURL())
                _ = file.getDataInBackground(completion: { (error: Error?, data: Data?, _: Bool) in
                    
                    self.item.loading = false
                    
                    if error == nil {
                        
                        if let resim = UIImage(data: data!) {
                            self.item.cacheState = "full"
                            self.item.coverImage = resim
                            
                            if (self.indexPath == indexPath) {
                                self.imageViewGridItem.image = self.item.coverImage
                            }
                            UIView.animate(withDuration: 0.3, animations: {
                                self.visualEffectViewBlur.alpha = 0
                            })
                        }
                    }
                })
            }
        } else {
            self.visualEffectViewBlur.alpha = 0
        }
    }
    
}
