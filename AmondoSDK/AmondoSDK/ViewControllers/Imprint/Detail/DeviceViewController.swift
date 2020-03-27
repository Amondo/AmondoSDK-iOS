//
//  DeviceViewController.swift
//  Amondo
//
//  Created by Timothy Whiting on 10/11/2016.
//  Copyright © 2016 Arcopo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Photos
import CoreLocation

class DeviceViewController: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableViewMap: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var initialFrame = CGRect(x: 160, y: 320, width: 160, height: 80)
    var transitionImageView=UIImageView()
    var image = UIImage()
    var asset:AMDAsset!
    
    var imageHeight:CGFloat!
    @IBOutlet weak var imageHeightStrut: NSLayoutConstraint!
    @IBOutlet weak var descriptionHeightStrut: NSLayoutConstraint!
    @IBOutlet weak var headerHeightStrut: NSLayoutConstraint!
    
    var tLayer: AVPlayerLayer?
    
    var aspectRatio:CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aspectRatio = CGFloat(asset.asset!.pixelHeight)/CGFloat(asset.asset!.pixelWidth)
        
        scrollView.frame=self.view.bounds
        tableView.frame=self.view.bounds
        tableViewMap.frame=self.view.bounds
        tableViewMap.frame.origin.x=self.view.bounds.width
        
        
        //descriptionHeightStrut.constant=asset.instagram!.description!.heightForView(descriptionLabel.font, width: self.view.bounds.width-30)+47
        if asset.type == "deviceVideo" {
            imageHeightStrut.constant=self.view.bounds.width*aspectRatio
        } else {
            imageHeightStrut.constant=self.view.bounds.width*(image.size.height/image.size.width)
        }
        
        headerHeightStrut.constant=imageHeightStrut.constant+descriptionHeightStrut.constant+46
        //self.view.layoutIfNeeded()
        let head = tableView.tableHeaderView!
        var newFrame = headerView.bounds;
        newFrame.size.height=headerHeightStrut.constant
        head.frame=newFrame
        
        let head2 = tableViewMap.tableHeaderView!
        var newFrame2 = headerView.bounds;
        newFrame2.size.height=headerHeightStrut.constant
        head2.frame=newFrame2
        
        //headerView.frame = newFrame;
        tableView.tableHeaderView=head
        tableViewMap.tableHeaderView=head2
        
        imageView.image=image
        transitionImageView.frame=initialFrame
        transitionImageView.contentMode = .scaleAspectFill
        transitionImageView.image=image
        transitionImageView.clipsToBounds=true
        transitionImageView.isUserInteractionEnabled=true
        imageView.isUserInteractionEnabled=true
        self.view.addSubview(transitionImageView)
        // Do any additional setup after loading the view.
        
        let imTap = UITapGestureRecognizer(target: self, action: #selector(DeviceViewController.imTap))
        tableView.tableHeaderView!.addGestureRecognizer(imTap)
        
        let imTap3 = UITapGestureRecognizer(target: self, action: #selector(DeviceViewController.imTap))
        tableViewMap.tableHeaderView!.addGestureRecognizer(imTap3)
        
        let imTap2 = UITapGestureRecognizer(target: self, action: #selector(DeviceViewController.imTap2))
        transitionImageView.addGestureRecognizer(imTap2)
        
        
        if asset.location != nil {
            scrollView.contentSize=CGSize(width: self.view.bounds.width*2, height: self.view.bounds.height)
            scrollView.delegate=self
        }
        
        print(asset.asset!.localIdentifier)
        
        if asset.type == "deviceVideo" {
            
            let layer = AVPlayerLayer(player: self.cellAvPlayer)
            
            
            self.cellAvPlayer?.isMuted=false
            layer.frame.origin=CGPoint.zero
            layer.frame.size.width=self.view.bounds.width
            layer.frame.size.height=self.view.bounds.width*aspectRatio
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.imageView.layer.addSublayer(layer)
            
            
            
            
            tLayer = AVPlayerLayer(player: self.cellAvPlayer)
            
            tLayer!.frame.size = self.initialFrame.size
            tLayer!.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.transitionImageView.layer.addSublayer(tLayer!)
            
            self.transitionImageView.alpha=1
            
            
            
        } else {
            
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            manager.requestImage(for: asset.asset!, targetSize: self.view.frame.size, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                self.imageView.image=result
                self.transitionImageView.image=result
            })
        }
        
        usernameLabel.text = AMDUser.currentUser()!.firstName!+" "+AMDUser.currentUser()!.lastName!
        
        //    usernameLabel.text = asset.instagram?.username
        //    dateLabel.text = "INSTAGRAM •"
        //    descriptionLabel.text = asset.instagram?.description
        //    likesLabel.text="\(asset.instagram!.likes)"
        //    locationLabel.text=asset.instagram?.location
        
        if asset.asset!.creationDate != nil {
            dateLabel.text = "IPHONE  •  \((asset.asset!.creationDate!).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none))"
        } else {
            dateLabel.text = "IPHONE"
        }
        
        
        if tableView.contentSize.height < tableViewMap.contentSize.height {
            let foot = UIView()
            foot.backgroundColor=UIColor.clear
            var footFrame = headerView.bounds;
            footFrame.size.height=tableViewMap.contentSize.height-tableView.contentSize.height
            foot.frame=footFrame
            //headerView.frame = newFrame;
            //        tableView.tableFooterView=foot
        }
        
        
        
        //addBlurViews()
    }
    
    var transBlur: UIVisualEffectView!
    var headerBlur: UIVisualEffectView!
    
    func addBlurViews(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        transBlur = UIVisualEffectView(effect: blurEffect)
        transBlur.frame = transitionImageView.bounds
        transBlur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        transitionImageView.addSubview(transBlur)
        
        headerBlur = UIVisualEffectView(effect: blurEffect)
        headerBlur.frame = imageView.bounds
        headerBlur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(headerBlur)
        
        if asset.cacheState == "full" {
            self.transBlur.alpha=0
            self.headerBlur.alpha=0
        }
    }
    
    func showAsset(){
        
        self.image = self.asset.coverImage!
        self.transitionImageView.image=self.image
        self.imageView.image=self.image
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.headerBlur.alpha=0
            self.transBlur.alpha=0
        }, completion: nil)
    }
    
    
    
    
    var cellAvPlayer: AVPlayer?
    
    
    @objc func imTap(){
        closeAnimation()
    }
    
    @objc func imTap2(){
        initialAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialAnimation()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        print(tableView.frame)
        print(tableView.scrollIndicatorInsets)
        if #available(iOS 11.0, *) {
            print(tableView.safeAreaInsets)
            //self.view.safeAreaInsets.top=
            //tableView.safeAreaInsets.top=0
            tableView.contentInset.top = -tableView.safeAreaInsets.top
        } else {
            // Fallback on earlier versions
        }
        print(tableView.contentInset)
        
    }
    
    func initialAnimation(){
        imageView.alpha=0
        self.transitionImageView.alpha=1
        tableView.frame.origin.y=self.view.bounds.height-self.imageHeightStrut.constant
        headerView.frame.origin.y=self.view.bounds.height-self.imageHeightStrut.constant
        UIView.animate(withDuration: 0.4, animations: {
            self.headerView.frame.origin.y=0
            self.tableView.frame.origin.y=0
            self.transitionImageView.frame.origin=CGPoint.zero
            self.transitionImageView.frame.size=CGSize(width: self.view.bounds.width,height: self.imageHeightStrut.constant)
            
            
            
            
            self.tLayer?.frame.size = CGSize(width: self.view.bounds.width,height: self.imageHeightStrut.constant)
            
            
            
        }, completion: { (b:Bool) in
            self.imageView.alpha=1
            self.transitionImageView.alpha=0
            
        })
    }
    var closing = false
    func closeAnimation(){
        closing = true
        
        let parent = self.parent as! ImprintViewController
        parent.showCells()
        
        cellAvPlayer?.isMuted=true
        
        imageView.alpha=0
        transitionImageView.alpha=1
        transitionImageView.frame.origin.y=headerView.frame.origin.y
        UIView.animate(withDuration: 0.4, animations: {
            self.tableView.frame.origin.y=self.view.bounds.height-self.imageView.bounds.height
            self.transitionImageView.frame=self.initialFrame
            self.tableViewMap.frame.origin.y=self.view.bounds.height-self.imageView.bounds.height
            self.tableView.contentOffset.y=0
            self.tableViewMap.contentOffset.y=0
            self.headerView.frame.origin.y=self.view.bounds.height-self.imageView.bounds.height
            
            self.tLayer?.frame.size = self.initialFrame.size
            
            
        }, completion: { (b:Bool) in
            //            parent.collectionView?.reloadData()
            self.view.removeFromSuperview()
        })
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("end dragging")
        if scrollView.contentOffset.y < -30 {
            //    scrollView.scrollEnabled=false
            //  scrollView.contentOffset.y=0
            closeAnimation()
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if closing==true{return}
        
        if scrollView==self.scrollView {
            return
        }
        
        if scrollView.contentOffset.y < 0 {
            //          headerView.frame.origin.y = 0
        } else {
            
        }
        
        headerView.frame.origin.y = -scrollView.contentOffset.y
        
        if scrollView == tableView {
            tableViewMap.contentOffset.y=scrollView.contentOffset.y
        } else {
            tableView.contentOffset.y=scrollView.contentOffset.y
        }
    }
    
}

extension DeviceViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tableViewMap {
            if asset.location == nil {
                return 0
            }
            return 2
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewMap {
            return 0
            //return 1
        }
        
        if section == 0 {
            return 1
        } else {
            // Comments
            return 0//1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewMap {
            return UITableViewCell()
            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
                
                
                let geoCoder = CLGeocoder()
                let location = CLLocation(latitude: (asset.asset?.location?.coordinate.latitude)!, longitude: (asset.asset?.location?.coordinate.longitude)!)
                var address="Photo location"
                
                
                geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                    
                    // Place details
                    var placeMark: CLPlacemark!
                    placeMark = placemarks?[0]
                    
                    
                    
                    if placeMark.addressDictionary != nil {
                        // Location name
                        if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                            print(locationName)
                        }
                        
                        // Street address
                        if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                            print(street)
                        }
                        
                        // City
                        if let city = placeMark.addressDictionary!["City"] as? NSString {
                            address = String(city)
                            print(city)
                        }
                        
                        // Zip code
                        if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                            print(zip)
                        }
                        
                        // Country
                        if let country = placeMark.addressDictionary!["Country"] as? NSString {
                            print(country)
                            address = address + ", " + String(country)
                        }
                    } else {
                        address = ""
                    }
                    
                    for view in cell.contentView.subviews {
                        if view.isKind(of: UILabel.self) {
                            let v = view as! UILabel
                            v.text = address
                        }
                    }
                    
                })
                
                for view in cell.contentView.subviews {
                    if view.isKind(of: UILabel.self) {
                        let v = view as! UILabel
                        v.text = address
                    }
                }
                
                return cell
            } else  {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                
                //gmaps
                /*
                 let camera = GMSCameraPosition.camera(withLatitude: asset.location!.coordinate.latitude, longitude: asset.location!.coordinate.longitude, zoom: 12.0)
                 let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
                 mapView.isMyLocationEnabled = true
                 mapView.frame=cell.contentView.frame
                 mapView.isUserInteractionEnabled=false
                 cell.contentView.addSubview(mapView)// = mapView
                 mapView.tag = -1
                 
                 // Creates a marker in the center of the map.
                 let marker = GMSMarker()
                 
                 marker.position = CLLocationCoordinate2D(latitude: asset.location!.coordinate.latitude, longitude: asset.location!.coordinate.longitude)
                 marker.title = ""
                 marker.snippet = ""
                 marker.map = mapView
                 
                 do {
                 // Set the map style by passing the URL of the local file.
                 if let styleURL = Bundle.main.url(forResource: "MapStyle", withExtension: "json") {
                 mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                 } else {
                 NSLog("Unable to find style.json")
                 }
                 } catch {
                 NSLog("The style definition could not be loaded: \(error)")
                 }
                 
                 */
                return cell
            }
            
        }
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            
            return cell
//            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
//
//            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableViewMap {
            if indexPath.section==0{
                return 40
            }
            let tvSize = self.tableView.contentSize.height-40-self.tableView.tableHeaderView!.frame.size.height
            if tvSize>self.view.bounds.height && tvSize > 0 {
                //   return tvSize
            }
            return self.view.bounds.height-40
        }
        if indexPath.section == 0 {
            return 60
        } else  {
            
            
            return 95
        }
    }
}
