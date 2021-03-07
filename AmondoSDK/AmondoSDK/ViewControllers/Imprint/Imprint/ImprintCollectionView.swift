//
//  ImprintCollectionView.swift
//  Amondo
//
//  Created by Timothy Whiting on 18/01/2018.
//  Copyright © 2019 Amondo. All rights reserved.
//

import UIKit

class SinglePageCell:UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    func prepareCells() {
        self.collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: Bundle(for: EventCollectionViewCell.self)), forCellWithReuseIdentifier: "cellEvent")
    }
}

class GridPageCell:UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    func prepareCells() {
        self.collectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: Bundle(for: EventCollectionViewCell.self)), forCellWithReuseIdentifier: "cellEvent")
    }
}

class SearchRowCell:UICollectionViewCell {
    
    @IBOutlet weak var artist:UILabel!
    @IBOutlet weak var info:UILabel!
    @IBOutlet weak var clock:UIImageView!
    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var indicator:UILabel!
    var indexPath:IndexPath!
    
    func setLabels(item:AMDImprintItem, indexPath:IndexPath){
        
        self.indexPath=indexPath
        indicator.isHidden=true
        artist.text = item.event!.artist
        info.text = "\(item.event!.location!)"
        if item.event?.date != nil {
            let formatter = DateFormatter()
            formatter.dateFormat="dd MMM yyyy"
            let dateString = formatter.string(from: item.event!.date! as Date)
        
            info.text = "\(dateString) ● \(item.event!.location!)"
        }
        if item.status == .upcoming {
            clock.isHidden = false
            if item.notified {
                //clock.image
                indicator.isHidden = false
            } else {
                //clock.image
            }
        } else {
            clock.isHidden = true
        }
        
        self.image.image = nil
        
        if item.image == nil {
            
            var data = AMDFile(file: item.object!["image"] as! Dictionary<String,Any>, ftype: "photo")
            
            if let video = item.object!["video"] as? Dictionary<String,Any> {
                
                if (video["url"] as? String) != nil {
                    data = AMDFile(file: item.object!["video"] as! Dictionary<String,Any>, ftype: "videoFrame")
                    data.format="png"
                    data.cacheUrl=data.cacheURLConstructor()
                    data.cached=data.checkDoesCacheExist()
                    
                }
            }
            data.quality = 100
            data.width = Int(UIScreen.main.bounds.width)
            data.height = Int(UIScreen.main.bounds.height)
            
            data.getDataInBackground(completion: { (error:Error?, data:Data?, cached:Bool) in
                if error == nil {
                    item.image = UIImage(data:data!)
                    if indexPath == self.indexPath {
                        self.image.image = UIImage(data:data!)
                    }
                }
            })
        } else {
            self.image.image=item.image
            
        }
    }
    
}

class GridCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageViewDate: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageViewLocation: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var artist: UITextView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var trButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var indicatorLabel: UILabel!
    
    var spinner:UIImageView?
    
    var indexPath: IndexPath!
    
    func gridCell(cell:GridCell, item:AMDImprintItem, indexPath:IndexPath,collectionView:UICollectionView) -> GridCell {
        cell.notificationView.isHidden = true
        cell.indexPath = indexPath
        cell.indicatorLabel.isHidden = true
        item.notified = AMDUser.currentUser()!.notifiedEvents.contains(item.objectID())

        if item.status == .upcoming {
            cell.trButton.isUserInteractionEnabled = false
        } else {
            cell.trButton.isUserInteractionEnabled = true
        }
        
        if item.notified {
            cell.indicatorLabel.isHidden = false
        } else {
            cell.indicatorLabel.isHidden = true
        }
        
        let contributed = item.contributed
        if contributed == false {
            cell.numberLabel.isHidden = true
        } else {
            cell.numberLabel.isHidden = false
            cell.numberLabel.text = "\(item.contributedAssetsCount)"
            
            let width = cell.numberLabel.text!.widthForView(UIFont.boldSystemFont(ofSize: 12), height: 24) + 16
            if width > 24 {
                cell.numberLabel.frame.size.width = width
            } else {
                cell.numberLabel.frame.size.width = 24
            }
        }
        
        if item.deviceAssets.count != 0 {
            cell.numberLabel.isHidden=false
            cell.numberLabel.text = "\(item.deviceAssets.count)"
        }
        
        if item.event == nil {
            return cell
        }
        
        cell.artist.text=item.event?.artist?.uppercased()
        cell.location.text=item.event?.location
        
        if (cell.imageViewLocation != nil && cell.imageViewDate != nil){
            cell.imageViewLocation!.frame.origin.x = 24 + cell.date.frame.origin.x + cell.date.frame.size.width
            cell.location!.frame.origin.x = 7 + cell.imageViewLocation.frame.origin.x + cell.imageViewLocation.frame.size.width
        }
        
        if item.event?.date != nil {
            let formatter = DateFormatter()
            formatter.dateFormat="dd MMM yy"// yyyy"
            let dateString = formatter.string(from: item.event!.date! as Date)
            cell.date.text = dateString
        }
        
        cell.image.image=nil
        
        if item.image == nil {
            var data = AMDFile(file: item.object!["image"] as! Dictionary<String,Any>, ftype: "photo")
            data.format = "png"
            data.width = Int(UIScreen.main.bounds.width)
            data.height = Int(UIScreen.main.bounds.height)
            
            if let video = item.object!["video"] as? Dictionary<String,Any> {
                
                if (video["url"] as? String) != nil {
                    data = AMDFile(file: item.object!["video"] as! Dictionary<String,Any>, ftype: "videoFrame")
                    data.format="png"
                    data.cacheUrl=data.cacheURLConstructor()
                    data.cached=data.checkDoesCacheExist()
                    
                }
            }
            
            cell.image.alpha = 0
            data.getDataInBackground(completion: { (error:Error?, data:Data?, cached:Bool) in
                if error == nil {
                    item.image = UIImage(data:data!)
                    if indexPath == cell.indexPath {
                        cell.image.image=UIImage(data:data!)
                        cell.image.animateOpacity(alpha: 1, duration: 0.3)
                    }
                }
            })
        } else {
            cell.image.alpha = 1
            cell.image.image = item.image
        }
        
        item.image=cell.image.image
        /*cell.artist.tag=indexPath.row*/
        //DINCond-Bold
        cell.artist.font = UIFont(name: "DINPro-CondensedBold", size: 70)
        let height = cell.artist.resizeFont()
        cell.artist.frame.origin.y = cell.location.frame.origin.y - 12 - height
        
        return cell
    }
    
}

class GenreCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
}

class GenreTitleCell: UICollectionViewCell {
    @IBOutlet weak var name: UIButton!
}

class MainMenuSection: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var items = [AMDImprintItem]()
    var name:String!
    var type:String!
    var state = "genres"
    var owner:UIViewController!
    var genres: [AMDGenre]?
    var selectedGenre:Int? = 0
    var cv: UICollectionView!
    
    func addNotificationForImprint(imprint:AMDImprintItem){

        AMDUser.currentUser()?.addUniqueEventNotified(id: imprint.objectID())
        
        UserAPIManager.saveNewEventNotification(event: imprint.objectID(), completion: { (error, success) in
            // .addUniqueObject(object: imprint.objectID(), forKey: "events_users_notified")
        })
        
    }
    
    func removeNotificationForImprint(imprint:AMDImprintItem){

        AMDUser.currentUser()?.removeEventNotified(id: imprint.objectID())
        UserAPIManager.deleteEventNotification(event: imprint.objectID(), completion: { (error, success) in
            // .removeObject(object: imprint.objectID(), forKey: "events_users_notified")
        })
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        owner?.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == "rows" {
            let item = items[indexPath.item]
            
            if item.status == .upcoming {
                if item.notified {
                    item.notified = false
                    removeNotificationForImprint(imprint: item)
                    collectionView.reloadItems(at: [indexPath])
                    
                } else {
                    item.notified = true
                    addNotificationForImprint(imprint: item)
                    collectionView.reloadItems(at: [indexPath])
                    
                }
                NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
            }
        }
        
        if type == "genre" {
            if state == "genres" {
                
                // Tapped genre tile e.g. R&B
                
                self.selectedGenre=indexPath.item
                self.state="singleGenre"
                
                collectionView.performBatchUpdates({
                    
                    let range = Range(uncheckedBounds: (0, collectionView.numberOfSections))
                    
                    let indexSet = IndexSet(integersIn: range)
                    collectionView.reloadSections(indexSet)
                    
                }, completion: nil)
                
            } else if state == "singleGenre" {
                if indexPath.section == 0 {
                    self.state = "genres"
                    self.selectedGenre = nil
                    collectionView.performBatchUpdates({
                        let range = Range(uncheckedBounds: (0, collectionView.numberOfSections))
                        
                        let indexSet = IndexSet(integersIn: range)
                        collectionView.reloadSections(indexSet)
                        
                    }, completion: nil)
                } else {
                    let item = genres![selectedGenre!].items[indexPath.item]
                    if item.status == .upcoming {
                        if item.notified {
                            item.notified = false
                            removeNotificationForImprint(imprint: item)
                            collectionView.reloadItems(at: [indexPath])
                        } else {
                            item.notified = true
                            addNotificationForImprint(imprint: item)
                            flashCell(collectionView: collectionView, indexPath: indexPath)
                        }
                        NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
                    }
                }
            }
            
        }
        if type == "grid" {
            let item = items[indexPath.item]
            if item.status == .upcoming {
                if item.notified {
                    item.notified = false
                    removeNotificationForImprint(imprint: item)
                    collectionView.reloadItems(at: [indexPath])
                } else {
                    item.notified = true
                    addNotificationForImprint(imprint: item)
                    flashCell(collectionView: collectionView, indexPath: indexPath)
                }
                NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
            }
        }
        
        if type == "single" {
            let item = items[indexPath.item]
            if item.status == .upcoming {
                if item.notified {
                    item.notified = false
                    removeNotificationForImprint(imprint: item)
                    collectionView.reloadItems(at: [indexPath])
                } else {
                    item.notified=true
                    addNotificationForImprint(imprint: item)
                    flashCell(collectionView: collectionView, indexPath: indexPath)
                    
                }
                NotificationCenter.default.post(name: Notification.Name("PROFILE_REFRESH"), object: nil)
            }
        }
    }
    
    func flashCell(collectionView:UICollectionView,indexPath:IndexPath) {
    
        if let cell = collectionView.cellForItem(at: indexPath) as? GridCell {
            if cell.notificationView.isHidden {
                cell.contentView.bringSubviewToFront(cell.notificationView)
                cell.notificationView.alpha = 0
                cell.notificationView.isHidden = false
                UIView.animate(withDuration: 0.3, animations: {
                    cell.notificationView.alpha = 1
                }, completion: { (done) in
                    cell.indicatorLabel.isHidden=false
                    cell.trButton.setImage(UIImage(named:"bell-selected"), for: .normal)
                    UIView.animate(withDuration: 0.3, delay: 1, options: UIView.AnimationOptions.allowUserInteraction, animations: {
                        cell.notificationView.alpha = 0
                    }, completion: { (done) in
                        cell.notificationView.isHidden = true
                    })
                })
            }
        }else if let cellEvent = collectionView.cellForItem(at: indexPath) as? EventCollectionViewCell {
            cellEvent.buttonAction.setImage(UIImage(named:"bell-selected"), for: .normal)
            cellEvent.viewNotification.alpha = 0
            cellEvent.viewNotification.isHidden = true
            cellEvent.prepareGfx()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if type == "genre" {
            if state == "genres" {
                return 2
            }
            if state == "singleGenre" {
                return 2
            }
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if type == "genre" {
            if state == "genres" {
                if section == 0 {
                    return 0
                } else {
                    return genres!.count
                }
            }
            if state == "singleGenre" {
                if section == 0 {
                    return 1
                } else {
                    return genres![selectedGenre!].items.count
                }
            }
        }
        return items.count
    }
    
    @objc func tappedLikeButton(button:UIButton){
        
        let index = button.tag
        var item:AMDImprintItem!
        if type == "single" {
            item=items[index]
        } else if type == "genre" {
            item=genres![selectedGenre!].items[index]
        } else if type == "grid" {
            item=items[index]
        }
        
        item.liked = !item.liked
        
        if item.liked {
            button.setImage(UIImage(named:"Heart"), for: .normal)
        } else {
            button.setImage(UIImage(named:"heart-open"), for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath){
        if type == "grid" {
            let cellEvent = cell as? EventCollectionViewCell
            cellEvent?.adjustToGridView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if type == "grid" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEvent", for: indexPath) as! EventCollectionViewCell
            let item = items[indexPath.item]
            cell.buttonAction.addTarget(self, action: #selector(self.tappedLikeButton(button:)), for: .touchUpInside)
            
            cell.prepareCell(item: item, indexPath: indexPath)
        }
        
        if type == "rows" {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "row", for: indexPath) as! SearchRowCell
            cell.setLabels(item: items[indexPath.item], indexPath:indexPath)
            return cell
        }
        
        
        if type == "genre" {
            if state == "genres" {
                if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreTitle", for: indexPath) as! GenreTitleCell
                    cell.name.setTitle(" "+genres![selectedGenre!].name, for: .normal)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreCell", for: indexPath) as! GenreCell
                    cell.name.text=genres![indexPath.item].name
                    
                    cell.image.image=nil
                    cell.image.tag=indexPath.item
                    let data = genres![indexPath.item].imageFile
                    
                    data!.getDataInBackground(completion: { (error, data, success) in
                        if success {
                            let image = UIImage(data: data!)
                            cell.image.image=image
                            
                        } else {
                            print(error)
                        }
                    })
                    return cell
                }
                
            }
            if state == "singleGenre" {
                if indexPath.section == 0 {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "genreTitle", for: indexPath) as! GenreTitleCell
                    cell.name.setTitle(" "+genres![selectedGenre!].name, for: .normal)
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
                    cell.trButton.tag=indexPath.item
                    cell.trButton.addTarget(self, action: #selector(self.tappedLikeButton(button:)), for: .touchUpInside)
                    return cell.gridCell(cell: cell, item: genres![selectedGenre!].items[indexPath.item], indexPath: indexPath, collectionView: collectionView)
                    
                }
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellEvent", for: indexPath) as! EventCollectionViewCell
        let item = items[indexPath.item]
        cell.buttonAction.addTarget(self, action: #selector(self.tappedLikeButton(button:)), for: .touchUpInside)
        
        cell.prepareCell(item: item, indexPath: indexPath)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if type == "single" {
            let height = collectionView.bounds.height-16
            return CGSize(width: (1/2)*height, height: height)
        }
        
        if type == "grid" {
            let width = (collectionView.bounds.width-24)/2
            return CGSize(width: width, height: 4/3*width)
        }
        
        if type == "rows" {
            let width = (collectionView.bounds.width)
            return CGSize(width: width, height: 64)
        }
        
        if type == "genre" {
            
            if state == "singleGenre" {
                if indexPath.section == 0 {
                    let width = (collectionView.bounds.width-16)
                    return CGSize(width: width, height: 40)
                }
            }
            if indexPath.section == 0 {
                let width = (collectionView.bounds.width-16)
                return CGSize(width: width, height: 40)
            }
            
            let width = (collectionView.bounds.width-24)/2
            return CGSize(width: width, height: 4/3*width)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
}
