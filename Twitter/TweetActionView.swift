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

class TweetActionView: UIView {

    var tweet: Tweet?
    var delegate: TweetActionDelegate?
    
    
    @IBAction func onReply(sender: AnyObject) {
//        println(tweet!.id!)
//        
//        
//        println("User reply")
        self.delegate?.onReply(tweet!)
        
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
//        println(tweet!.id!)
//        println("User retweet")
        self.delegate?.onRetweet(tweet!)
    
    }

    @IBAction func onFavorite(sender: AnyObject) {
//        println(tweet!.id!)
//        println("User favorite")
        self.delegate?.onFavorite(tweet!)
    
    }

    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
