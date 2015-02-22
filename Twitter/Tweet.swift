//
//  Tweet.swift
//  Twitter
//
//  Created by Ryan Newton on 2/19/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var id: NSString?
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var dictionary: NSDictionary
    var favoriteCount: NSInteger?
    var retweetCount: NSInteger?
    
    
//    var userImageUrl: NSURL?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        id = dictionary["id_str"] as? NSString
        user = User(dictionary: dictionary["user"] as NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
//        userImageUrl = NSURL(user?.profileImageUrl)
        
        favoriteCount = dictionary["favorite_count"] as? NSInteger
        retweetCount = dictionary["retweet_count"] as? NSInteger
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsFromArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        
        
        for tweetDict in array {
            tweets.append(Tweet(dictionary: tweetDict))
        }
        
        return tweets        
    }
    
    
    
    
}
