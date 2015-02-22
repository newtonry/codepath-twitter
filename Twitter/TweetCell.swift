//
//  TweetCell.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func fillFromTweet(tweet: Tweet) {
        let thumbUrl = NSURL(string: tweet.user!.profileImageUrl!)
        tweetLabel.text = tweet.text
        userLabel.text = tweet.user!.name
        thumbnail.setImageWithURL(thumbUrl)
        
    }
    
}
