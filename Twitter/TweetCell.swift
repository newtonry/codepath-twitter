//
//  TweetCell.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell, UIGestureRecognizerDelegate {
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!    
    @IBOutlet weak var thumbnail: Thumbnail!
    @IBOutlet weak var actionView: TweetActionView!
    @IBOutlet weak var createdAtLabel: UILabel!
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillFromTweet(tweet: Tweet) {
        self.tweet = tweet
        let thumbUrl = NSURL(string: tweet.user!.profileImageUrl!)
        tweetLabel.text = tweet.text
        userLabel.text = tweet.user!.name
        screennameLabel.text = "@\(tweet.user!.screenname!)"
        thumbnail.setImageWithURL(thumbUrl)
        actionView.tweet = tweet
    
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d"
        self.createdAtLabel.text = "\(dateFormatter.stringFromDate(tweet.createdAt!))"
    
        
    }
}
