//
//  IndividualTweetViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class IndividualTweetViewController: UIViewController, TweetActionDelegate {
    var tweet: Tweet?
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var retweetsCountLabel: UILabel!
    @IBOutlet weak var favoritesCountLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var actionView: TweetActionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replyButton = UIBarButtonItem(title: "Reply", style: UIBarButtonItemStyle.Plain, target: self, action: "onReply")
        self.navigationItem.rightBarButtonItem = replyButton
        
        if let tw = tweet {
            usernameLabel.text = tw.user!.name!
            handleLabel.text = "@\(tw.user!.screenname!)"
            favoritesCountLabel.text = "\(tw.favoriteCount!) favorited"
            retweetsCountLabel.text = "\(tw.retweetCount!) retweets"
            
            let imageUrl = NSURL(string: tw.user!.profileImageUrl!)
            thumbnailImageView.setImageWithURL(imageUrl)
            tweetMessageLabel.text = tw.text!
            timestampLabel.text = tw.createdAtString!
            actionView.tweet = tw
        }
        
        actionView.delegate = self
    }
    
    
    func onReply(tweet: Tweet) {
        let newTweetNavigationController = storyboard!.instantiateViewControllerWithIdentifier("NewTweetNavigationController") as UINavigationController
        self.presentViewController(newTweetNavigationController, animated: true, completion: nil)
    }
    
    
    
    func onRetweet(tweet: Tweet) {
        TwitterClient.sharedInstance.retweetTweet(tweet, completion: { (response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            println("In retweet cb")
            }
        )
    }
    
    func onFavorite(tweet: Tweet) {
        TwitterClient.sharedInstance.favoriteTweet(tweet, completion: { (response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            println("In favorite cb")
            }
        )
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
