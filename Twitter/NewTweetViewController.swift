//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit


class NewTweetViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillUserDetails()
        
        
        User.currentUser?.profileImageUrl
        
        tweetTextView.becomeFirstResponder()
        

        // Do any additional setup after loading the view.
    }

    func fillUserDetails() {
        let user = User.currentUser!
        let userImageUrl = NSURL(string: user.profileImageUrl!)
        userImage.setImageWithURL(userImageUrl)
        
        userName.text = user.name!
//        userHandle.text = user.screenname!
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onTweet(sender: AnyObject) {
        let message = tweetTextView.text
        let params = ["status": message]
        
       
        
        
        TwitterClient.sharedInstance.postTweet(params, completion: {(response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            

            
                self.dismissViewControllerAnimated(true, completion: nil)
            
            
            
            }
        )
        
        
        
    }

}
