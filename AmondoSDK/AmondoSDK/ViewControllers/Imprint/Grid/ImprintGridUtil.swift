//
//  ImprintGridUtil.swift
//  Amondo
//
//  Created by developer@amondo.com on 3/19/19.
//  Copyright © 2019 Amondo. All rights reserved.
//

import Foundation
import UIKit
import Photos
import Alamofire

class ImprintGridUtil {
    
    static func registerCells(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "GridImageCollectionViewCell", bundle: Bundle(for: GridImageCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridImage")
        collectionView.register(UINib(nibName: "GridVideoCollectionViewCell", bundle: Bundle(for: GridVideoCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridVideo")
        collectionView.register(UINib(nibName: "GridArticleCollectionViewCell", bundle: Bundle(for: GridArticleCollectionViewCell.self)), forCellWithReuseIdentifier: "cellGridArticle")
        
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: Bundle(for: VideoCollectionViewCell.self)), forCellWithReuseIdentifier: "video")
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: Bundle(for: ImageCollectionViewCell.self)), forCellWithReuseIdentifier: "image")
        collectionView.register(UINib(nibName: "CuratedVideoCollectionViewCell", bundle: Bundle(for: CuratedVideoCollectionViewCell.self)), forCellWithReuseIdentifier: "cvideo")
    }
    
    static func cellForAsset(item: AMDAsset, collectionView: UICollectionView, indexPath: IndexPath, parent: UIView, downloadQueue: inout [DataRequest], gridStyle: ImprintGridStyle) -> UICollectionViewCell {
        if item.type == "photo" || item.type == "status" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGridImage", for: indexPath) as! GridImageCollectionViewCell
            cell.item = item
            cell.gridStyle = gridStyle
            cell.prepareCell(indexPath: indexPath)
            
            return cell
        } else if item.type == "music" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            cell.gridStyle = gridStyle
            
            let r = cell.displayImageWithDownload(item: item, indexPath: indexPath, vcView: parent, completion: { (firstLoad, success) in
                
            })
            
            cell.alpha = 1
            
            return cell
        } else if item.type == "url" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGridArticle", for: indexPath) as! GridArticleCollectionViewCell
            cell.gridStyle = gridStyle
            
            let r = cell.displayImageWithDownload(item: item, indexPath: indexPath, vcView: parent, completion: { (firstLoad, success) in
                
            })
            
            
            cell.alpha = 1
            
            return cell
        } else if item.type == "video" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvideo", for: indexPath) as! CuratedVideoCollectionViewCell
            cell.indexPath = indexPath
            cell.gridStyle = gridStyle
            cell.imageViewFrame.image = item.coverImage
            cell.blur.alpha = 1
            
            if item.avPlayer == nil {
                cell.clearAvPlayer()
                if item.loading == false {
                    item.loading = true
                    let file = AMDFile(file: item.aobject!["file"] as! Dictionary<String,Any>, ftype: "video")
                    file.width = Int(300)
                    file.height = Int(300)
                    file.quality = 80
                    
                    file.cacheUrl = file.cacheURLConstructor()
                    file.cached = file.checkDoesCacheExist()
                    
                    let r = file.getDataInBackground(completion: { (error:Error?, data:Data?, cached:Bool) in
                        item.loading = false
                        if error == nil {
                            file.type = AMDFileType.video
                            file.cacheUrl = file.cacheURLConstructor()
                            file.cached = file.checkDoesCacheExist()
                            item.dataURL = file.cacheUrl
                            
                            item.avPlayer = file.dataToVideo_AVPlayer()
                            item.cacheState = "full"
                            
                            if cell.indexPath == indexPath {
                                cell.avPlayer = item.avPlayer!
                                cell.playAvPlayer(item.avPlayer!)
                                UIView.animate(withDuration: 0.3, animations: {
                                    cell.blur.alpha = 0
                                })
                                cell.avPlayer.play()
                            }
                        }
                    })
                    if r != nil {
                        downloadQueue.append(r!)
                    }
                }
            } else {
                cell.avPlayer = item.avPlayer!
                cell.playAvPlayer(item.avPlayer!)
                cell.avPlayer.play()
                
                UIView.animate(withDuration: 0.3, animations: {
                    cell.blur.alpha = 0
                })
            }
            return cell
        }
        
        if item.asset?.mediaType  == .image {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageCollectionViewCell
            let option = PHImageRequestOptions()
            
            let csize = CGSize(width: cell.frame.size.width*2, height: cell.frame.size.height*2)
            
            PHImageManager.default().requestImage(for: item.asset!, targetSize: csize, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                if result != nil {
                    cell.imageView.image = result!
                    item.coverImage=result!
                }
            })
            
            cell.logoView.image = nil
            cell.alpha = 1
            cell.blur.alpha = 0
            
            return cell
        }
        
        if item.asset?.mediaType  == .video {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvideo", for: indexPath) as! CuratedVideoCollectionViewCell
            cell.gridStyle = gridStyle
            cell.playVideoFile(nil, avPlayerAMD: item.avPlayer, url: nil)
            cell.blur.alpha = 0
            
            return cell
        }
        
        if item.asset?.mediaType  == .video {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvideo", for: indexPath) as! CuratedVideoCollectionViewCell
            cell.gridStyle = gridStyle
            cell.playVideoFile(nil, avPlayerAMD: item.avPlayer, url: nil)
            cell.blur.alpha = 0
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unsupported", for: indexPath)
        for v in cell.contentView.subviews {
            if v.isKind(of: UILabel.self) {
                (v as! UILabel).text = "unsupported\n\(item.objectId())"
            }
        }
        return cell
    }
}
