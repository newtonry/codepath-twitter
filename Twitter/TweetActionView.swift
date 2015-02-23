//
//  TweetActionView.swift
//  Twitter
//
//  Created by Ryan Newton on 2/22/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

protocol TweetActionDelegate {
    func onReply(tweet: Tweet)
    func onRetweet(tweet: Tweet)
    func onFavorite(tweet: Tweet)
}

// This class was intended to control the three buttons, which keep on appearing. However, I'm not a fan at the moment
class TweetActionView: UIView {
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    var delegate: TweetActionDelegate?

    
    // Seems like this should just run on load or something
    func setButtons() {
        if tweet!.retweeted! {
            let image = UIImage(named: "retweet-on.png")
            retweetButton.setImage(image, forState: .Normal)
        }
        
        if tweet!.favorited! {
            let image = UIImage(named: "favorite_on.png")
            favoriteButton.setImage(image, forState: .Normal)
        }
        
        println("esetup")
    }
    
    
    @IBAction func onReply(sender: AnyObject) {
        self.delegate?.onReply(tweet!)
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        let image = UIImage(named: "retweet-on.png")
        retweetButton.setImage(image, forState: .Normal)
        self.delegate?.onRetweet(tweet!)
    
    }

    @IBAction func onFavorite(sender: AnyObject) {
        let image = UIImage(named: "favorite_on.png")
        favoriteButton.setImage(image, forState: .Normal)
        self.delegate?.onFavorite(tweet!)
    
    }
}
