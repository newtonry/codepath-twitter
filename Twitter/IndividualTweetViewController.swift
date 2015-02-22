//
//  IndividualTweetViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class IndividualTweetViewController: UIViewController {
    var tweet: Tweet?
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var retweetsCountLabel: UILabel!
    
    @IBOutlet weak var favoritesCountLabel: UILabel!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var tweetMessageLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replyButton = UIBarButtonItem(title: "Reply", style: UIBarButtonItemStyle.Plain, target: self, action: "onReply")
        self.navigationItem.rightBarButtonItem = replyButton
    
        
        if let tw = tweet {
            usernameLabel.text = tw.user!.name!
            handleLabel.text = tw.user!.screenname!
            favoritesCountLabel.text = "\(tw.favoriteCount!) favorited"
            retweetsCountLabel.text = "\(tw.retweetCount!) retweets"
            
            let imageUrl = NSURL(string: tw.user!.profileImageUrl!)
            thumbnailImageView.setImageWithURL(imageUrl)
            tweetMessageLabel.text = tw.text!
            timestampLabel.text = tw.createdAtString!
        }
        
        
        
        // Do any additional setup after loading the view.
    }

//    func onReply() {
//        let newTweetNavigationController = storyboard!.instantiateViewControllerWithIdentifier("NewTweetNavigationController") as UINavigationController
//        self.presentViewController(newTweetNavigationController, animated: true, completion: nil)
//        
//        
//    }
    
    
    @IBAction func onReply(sender: AnyObject) {
        let newTweetNavigationController = storyboard!.instantiateViewControllerWithIdentifier("NewTweetNavigationController") as UINavigationController
        
        
        self.presentViewController(newTweetNavigationController, animated: true, completion: nil)
        
        
        
    }
    
    
    
    @IBAction func onRetweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweetTweet(tweet!, completion: { (response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            println("In retweet cb")
            }
        )
    }
    
    
    @IBAction func onFavorite(sender: AnyObject) {
        
        TwitterClient.sharedInstance.favoriteTweet(tweet!, completion: { (response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            println("In favorite cb")
            }
        )
        
        
        
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
