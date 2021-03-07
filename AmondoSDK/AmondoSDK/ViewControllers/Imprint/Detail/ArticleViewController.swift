//
//  ArticleViewController.swift
//  Amondo
//
//  Created by Timothy Whiting on 04/11/2016.
//  Copyright © 2016 Arcopo. All rights reserved.
//

import UIKit
import WebKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setStars(_ number:Int){
        if number == 0 {
            starsLabel.text = "☆☆☆☆☆"
        } else if number == 1 {
            starsLabel.text = "★☆☆☆☆"
        } else if number == 2 {
            starsLabel.text = "★★☆☆☆"
        } else if number == 3 {
            starsLabel.text = "★★★☆☆"
        } else if number == 4 {
            starsLabel.text = "★★★★☆"
        } else if number == 5 {
            starsLabel.text = "★★★★★"
        }
        
    }
    
}

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var initialFrame = CGRect(x: 160, y: 320, width: 160, height: 80)
    var transitionImageView=UIImageView()
    var image = UIImage()
    var asset:AMDAsset!
    
    var wv:WKWebView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.frame.size.height=self.view.bounds.width*(image.size.height/image.size.width)+49
        self.view.layoutIfNeeded()
        let head = tableView.tableHeaderView!
        var newFrame = headerView.bounds;
        newFrame.size.height=self.view.bounds.width*(image.size.height/image.size.width)+49
        head.frame=newFrame
        tableView.tableHeaderView=head
        
        
        
        imageView.image=image
        transitionImageView.frame=initialFrame
        transitionImageView.contentMode = .scaleAspectFill
        transitionImageView.image=image
        transitionImageView.clipsToBounds=true
        transitionImageView.isUserInteractionEnabled=true
        imageView.isUserInteractionEnabled=true
        self.view.addSubview(transitionImageView)
        // Do any additional setup after loading the view.
        
        let imTap = UITapGestureRecognizer(target: self, action: #selector(ArticleViewController.imTap))
        tableView.tableHeaderView!.addGestureRecognizer(imTap)
        
        let imTap2 = UITapGestureRecognizer(target: self, action: #selector(ArticleViewController.imTap2))
        transitionImageView.addGestureRecognizer(imTap2)
        // Do any additional setup after loading the view.
        
        if !Optional.isNil(asset.aobject!["avatar"]) {
            let file = AMDFile(file: asset.aobject!["avatar"] as! Dictionary<String, Any>, ftype: "photo")
            file.getDataInBackground { (error:Error?, data:Data?, cached:Bool) in
                if error == nil {
                    let img = UIImage(data: data!)
                    self.logoImage.image = img
                }
            }
        }
        
        
        publisherLabel.text = asset.article?.publisher
        timeLabel.text = "ARTICLE  •  \((asset.date).stringDate(DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none))"
        
        tableView.isPagingEnabled=true
        tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.isUserInteractionEnabled=false
        
        addBlurViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            tableView.contentInset.top = -tableView.safeAreaInsets.top
        }
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
    
    @objc func imTap(){
        closeAnimation()
    }
    @objc func imTap2(){
        initialAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        wv.loadHTMLString("", baseURL: nil)
        wv.removeFromSuperview()
        wv=nil
    }
    
    func initialAnimation(){
        imageView.alpha=0
        self.transitionImageView.alpha=1
        tableView.frame.origin.y=self.view.bounds.height-imageView.bounds.height
        //   headerView.frame.origin.y=self.view.bounds.height-imageView.bounds.height
        UIView.animate(withDuration: 0.4, animations: {
            self.headerView.frame.origin.y=0
            self.tableView.frame.origin.y=0
            
            self.transitionImageView.frame.origin=CGPoint.zero
            self.transitionImageView.frame.size.width=self.view.bounds.width
            self.transitionImageView.frame.size.height=self.view.bounds.width*(self.image.size.height/self.image.size.width)
        }, completion: { (b:Bool) in
            self.imageView.alpha=1
            self.transitionImageView.alpha=0
            
        })
    }
    
    var closing=false
    func closeAnimation(){
        
        closing = true
        
        let parent = self.parent as! ImprintViewController
        parent.showCells()
        
        imageView.alpha=0
        transitionImageView.alpha=1
        transitionImageView.frame.origin.y = -tableView.contentOffset.y
        UIView.animate(withDuration: 0.4, animations: {
            self.tableView.frame.origin.y=self.view.bounds.height-self.imageView.bounds.height
            self.transitionImageView.frame=self.initialFrame
            self.tableView.contentOffset.y=0
            //           self.headerView.frame.origin.y=self.view.bounds.height
        }, completion: { (b:Bool) in
            //            parent.collectionView?.reloadData()
            self.view.removeFromSuperview()
        })
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -30 {
            closeAnimation()
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if closing {return}
        if scrollView.tag==3 {
            if scrollView.contentOffset.y <= 0 {
                tableView.contentOffset.y+=scrollView.contentOffset.y
                scrollView.contentOffset.y=0
            } else {
                tableView.setContentOffset(CGPoint(x: 0, y: tableView.contentSize.height-self.view.bounds.height), animated: true)
            }
            
            if tableView.contentOffset.y < 0 {
                tableView.setContentOffset(CGPoint.zero, animated: true)
            }
        }
        if scrollView == tableView {
            if scrollView.contentOffset.y < 20 {
                tableView.isPagingEnabled=true
                tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.isUserInteractionEnabled=false
                //            headerView.frame.origin.y = scrollView.contentOffset.y
            } else {
                tableView.isPagingEnabled=false
                tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.isUserInteractionEnabled=true
                //          headerView.frame.origin.y=0
            }
        }
        
    }
}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0", for: indexPath) as! ArticleCell
            cell.authorLabel.text = asset.article?.author
            cell.descriptionLabel.text = asset.article?.description
            cell.setStars(asset.article!.stars)
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "webCell", for: indexPath)
            let webView = WKWebView(frame: cell.contentView.bounds)
            let url = URL(string: asset.article!.url!);
            let requestObj = URLRequest(url: url!);
            self.wv=webView
            webView.load(requestObj);
            cell.addSubview(webView)
            webView.backgroundColor=UIColor.clear
            webView.scrollView.delegate=self
            webView.scrollView.tag=3
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.setContentOffset(CGPoint.zero, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 117
        }else  {
            return self.view.bounds.height//-117
        }
    }
}
