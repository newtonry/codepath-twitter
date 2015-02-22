//
//  TwitterClient.swift
//  Twitter
//
//  Created by Ryan Newton on 2/18/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//


let TWITTER_CONSUMER_KEY = "Z9apaPrYR44YSG9xZiSRkcMj6"
let TWITTER_CONSUMER_SECRET = "GZz7HnUhhjhYk6UnVe14ijRyZ17h2a0BwDomI7l3n9IpAk0qW7"
let TWITTER_BASE_URL = NSURL(string: "https://api.twitter.com")



class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: TWITTER_BASE_URL, consumerKey: TWITTER_CONSUMER_KEY, consumerSecret: TWITTER_CONSUMER_SECRET)
        }
    
        return Static.instance
        
    }

    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        
        // Fetch request token and redirect to authorization
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }, failure: {(error: NSError!) -> Void in
                self.loginCompletion!(user: nil, error: error)
        })
    }
    
    func openUrl(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            println("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)            
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var user = User(dictionary: response as NSDictionary)
                
                println(user.name)

                User.currentUser = user
                self.loginCompletion?(user: user, error: nil)
                
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                self.loginCompletion!(user: nil, error: error)
                    println("There was an error hitting the endpoint.")
                }
            )
            
            }, failure: { (error: NSError!) -> Void in
                println("Error fetching access token")
                self.loginCompletion!(user: nil, error: error)
            }
        )
    }
    
    func homeTimelineWithCompletion(params: NSDictionary?, completion: (tweets:[Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsFromArray(response as [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                completion(tweets: nil, error: error)
                println(error.localizedDescription)
            }
        )
    }

    
    func favoriteTweet(tweet: Tweet, completion: (response: AFHTTPRequestOperation?, error: NSError?) -> ()) {
        let params = ["id": tweet.id!]
        postToEnpointWithParams("1.1/favorites/create.json", params: params, completion: completion)
    }
    
    func retweetTweet(tweet: Tweet, completion: (response: AFHTTPRequestOperation?, error: NSError?) -> ()) {
        
        
        let endpoint = "1.1/statuses/retweet/\(tweet.id!).json"

        
        
        //        let params = ["id": tweet.id!]
        
        
        postToEnpointWithParams(endpoint, params: nil, completion: completion)
        
    }
    
    
    func postToEnpointWithParams(endpoint: NSString, params: NSDictionary?, completion: (response: AFHTTPRequestOperation?, error: NSError?) -> ()) {
        POST(endpoint, parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println("The POST to \(endpoint) a success!")
            completion(response: operation, error: nil)
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                println(operation)
                println("The POST to \(endpoint) failed. \(error.localizedDescription)")
                completion(response: nil, error: error)
            
            }
        )
    }
    
    
    func postTweet(params: NSDictionary?, completion: (response: AFHTTPRequestOperation?, error: NSError?) -> ()) {
        postToEnpointWithParams("1.1/statuses/update.json", params: params, completion: completion)
    }
}