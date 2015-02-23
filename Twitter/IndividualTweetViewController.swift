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
    @IBOutlet weak var thumbnailImageView: Thumbnail!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var actionView: TweetActionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red: 0.333, green: 0.675, blue: 0.933, alpha: 1.0)
        
        if let tw = tweet {
            usernameLabel.text = tw.user!.name!
            handleLabel.text = "@\(tw.user!.screenname!)"
            favoritesCountLabel.text = "\(tw.favoriteCount!) favorited"
            retweetsCountLabel.text = "\(tw.retweetCount!) retweets"
            
            let imageUrl = NSURL(string: tw.user!.profileImageUrl!)
            thumbnailImageView.setImageWithURL(imageUrl)
            tweetMessageLabel.text = tw.text!

            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM d"
            timestampLabel.text = "\(dateFormatter.stringFromDate(tw.createdAt!))"
            actionView.tweet = tw
            actionView.setButtons()
        }
        
        actionView.delegate = self
    }
    
    func onReply(tweet: Tweet) {
        let newTweetNavigationController = storyboard!.instantiateViewControllerWithIdentifier("NewTweetNavigationController") as UINavigationController
        self.presentViewController(newTweetNavigationController, animated: true, completion: nil)

    }
    
    func onRetweet(tweet: Tweet) {

        
        TwitterClient.sharedInstance.retweetTweet(tweet, completion: { (response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            if let res = response {
                self.tweet = tweet
                self.tweet!.retweetCount = self.tweet!.retweetCount! + 1
                self.retweetsCountLabel.text = "\(self.tweet!.retweetCount!) retweets"
            }
            }
        )
    }
    
    func onFavorite(tweet: Tweet) {
        TwitterClient.sharedInstance.favoriteTweet(tweet, completion: { (response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            if let res = response {
                self.tweet = tweet
                self.tweet!.favoriteCount = self.tweet!.favoriteCount! + 1
                self.favoritesCountLabel.text = "\(self.tweet!.favoriteCount!) favorited"
            }
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
