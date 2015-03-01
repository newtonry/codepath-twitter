//
//  UserViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/26/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController {
    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.getProfileBannerForUser(user!, completion: {( backgroundUrl: NSURL?, error: NSError?)-> Void in
            
            if (backgroundUrl != nil) {
                self.headerBackgroundImage.setImageWithURL(backgroundUrl!)
            }
            
            self.userImage.setImageWithURL(NSURL(string:self.user!.profileImageUrl!))
        })

        self.followingCount.text = "\(user!.followingCount!)"
        self.followersCount.text = "\(user!.followersCount!)"
        self.tweetCount.text = "\(user!.tweetCount!)"

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
