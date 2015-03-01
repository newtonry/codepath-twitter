//
//  User.swift
//  Twitter
//
//  Created by Ryan Newton on 2/19/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "currentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name: String?
    var id: NSInteger?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var profileBackgroundUrl: NSURL?
    var profileImageHigh: NSURL?
    var tweetCount: NSInteger?
    var followersCount: NSInteger?
    var followingCount: NSInteger?
    
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        let profileBackgroundUrlString = self.dictionary["profile_background_image_url"] as? String
        profileBackgroundUrl =  NSURL(string: profileBackgroundUrlString!)

        tweetCount = dictionary["statuses_count"] as? NSInteger
        followersCount = dictionary["followers_count"] as? NSInteger
        followingCount = dictionary["friends_count"] as? NSInteger
        
        profileImageHigh = NSURL(string: profileImageUrl!.stringByReplacingOccurrencesOfString("_normal", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil))
        
        id = dictionary["id"] as? NSInteger
        
    
    }
    
    
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    
    
    class var currentUser: User? {
        get {
        
        
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
        
                    
        
                }
            }
        
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
    
    
    
}
