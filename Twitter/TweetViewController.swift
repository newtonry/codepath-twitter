//
//  TweetViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/20/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetActionDelegate {
    
    var tweetsArray: [Tweet]?
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var actionView: TweetActionView!
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
        println("Logging the user out.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(nil, completion: { (tweets, error) -> Void in
            self.tweetsArray = tweets
            self.tableView.reloadData()
        })
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.addPullToRefreshWithActionHandler(refreshTweets)
        self.tableView.addInfiniteScrollingWithActionHandler(pullMoreTweetsHandler)
    }
    
    func refreshTweets() {
        let lastTweet = tweetsArray![0]
        let params = ["since_id": lastTweet.id!]

        TwitterClient.sharedInstance.homeTimelineWithCompletion(params, completion: { (tweets, error) -> Void in
            println("Refreshing tweets")

            if let twts = tweets {
                twts.reverse()
                for tweet in twts {
                    self.tweetsArray!.insert(tweet, atIndex: 0)
                }
            self.tableView.reloadData()
            } else {
                println("There are no new tweets")
            }
            self.tableView.pullToRefreshView.stopAnimating()
        })
    }
    
    func pullMoreTweetsHandler() {
        let oldestTweet = tweetsArray![tweetsArray!.count - 1]  // This is making the assumption that the last tweet we receive is always the oldest, which may not always be the case
        let params = ["max_id": oldestTweet.id!]
        
        
        TwitterClient.sharedInstance.homeTimelineWithCompletion(params, completion: { (tweets: [Tweet]?, error: NSError?) -> Void in
        println("Loading in more tweets")
            if let twts = tweets {
                for tweet in twts {
                    self.tweetsArray?.append(tweet)
                }
            self.tableView.infiniteScrollingView.stopAnimating()
            self.tableView.reloadData()
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        let tweet = tweetsArray![indexPath.row]
        cell.fillFromTweet(tweet)
        cell.actionView.delegate = self  // I think this is an awful pattern, I regret doing this!
        cell.actionView.setButtons()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = tweetsArray {
            return tweetsArray!.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tweet = tweetsArray![indexPath.row]
        let individualTweetViewController = storyboard!.instantiateViewControllerWithIdentifier("IndividualTweetViewController") as IndividualTweetViewController
        individualTweetViewController.tweet = tweet
        self.navigationController?.pushViewController(individualTweetViewController, animated: true)
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

    
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
//        let tweet = tweetsArray![indexPath.row]
//        cell.fillFromTweet(tweet)
//        cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
//        return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height + 1
//    }
}
