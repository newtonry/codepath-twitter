//
//  UserViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/26/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var profileHeaderView: UIView!

    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!

    @IBOutlet weak var tableView: UITableView!

    private var panStartY: CGFloat?
    private var bannerStartFrame: CGRect?
    
    var tweets: [Tweet]?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupUserDetails()
        setupPullRecognizer()
    }
    
    func setupTableView() {
        // should honestly probably just make the table view its own controller
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None;
        
        TwitterClient.sharedInstance.userTweetsWithCompletion(user!, completion: { (tweets, error) -> Void in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }
    
    func setupUserDetails() {
        TwitterClient.sharedInstance.getProfileBannerForUser(user!, completion: {( backgroundUrl: NSURL?, error: NSError?)-> Void in
            if (backgroundUrl != nil) {
                self.headerBackgroundImage.setImageWithURL(backgroundUrl!)
            }
            self.userImage.setImageWithURL(self.user?.profileImageHigh!)
            self.bannerStartFrame = self.headerBackgroundImage.frame
        })

        userImage.layer.cornerRadius = 8
        userImage.clipsToBounds = true
        
        profileHeaderView.clipsToBounds = true
        headerBackgroundImage.clipsToBounds = true
        
        self.followingCount.text = "\(user!.followingCount!)"
        self.followersCount.text = "\(user!.followersCount!)"
        self.tweetCount.text = "\(user!.tweetCount!)"
    }

    func setupPullRecognizer() {
        let recognizer = UIPanGestureRecognizer(target: self, action: "beingPulled:")
        self.view.addGestureRecognizer(recognizer)
    }
    
    func beingPulled(sender: UIPanGestureRecognizer) {
        super.showHamburgerMenu(sender)  // Had to do this to keep the pull to show hamburger menu
        switch (sender.state){
        case .Began:
            panStartY = sender.locationInView(self.view).y
        case .Changed:
            let location = sender.locationInView(self.view)
            let pointDifference = location.y - panStartY!
            
            if pointDifference > 0 {
                let newRatio = (100.0 + pointDifference * 0.3)/100
                var newWidth =  newRatio * bannerStartFrame!.width
                var newHeight = newRatio * bannerStartFrame!.height
                var newXorigin =  bannerStartFrame!.origin.x - (newWidth - bannerStartFrame!.width)/2  // To keep it centered
                
                let newFrame = CGRect(x: newXorigin, y: bannerStartFrame!.origin.y, width: newWidth, height: newHeight)
                headerBackgroundImage.frame = newFrame
            }

        case .Ended, .Cancelled:
            println("Done")
            UIView.animateWithDuration(0.1, animations: {
                self.headerBackgroundImage.frame = self.bannerStartFrame!
            })
        default:
            NSLog("Unhandled state")
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProfileStatusCell") as ProfileStatusCell
        cell.statusBody.text = tweets![indexPath.row].text
        UIView.animateWithDuration(0.5, animations: {
            cell.statusBody.alpha = 1
        })
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let twts = tweets {
            return twts.count
        }
        return 0
    }
}
