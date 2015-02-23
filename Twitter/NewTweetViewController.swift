//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit


class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userImage: Thumbnail!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var remainingLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillUserDetails()
        User.currentUser?.profileImageUrl
        tweetTextView.becomeFirstResponder()
        remainingLabel.text = "\(lettersLeft()) remaining"
        self.tweetTextView.delegate = self
    }

    func fillUserDetails() {
        let user = User.currentUser!
        let userImageUrl = NSURL(string: user.profileImageUrl!)
        userImage.setImageWithURL(userImageUrl)
        
        userName.text = user.name!
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

    func textViewDidChange(textView: UITextView) {
        remainingLabel.text = "\(lettersLeft()) remaining"
    }

    func lettersLeft() -> Int {
        let text = tweetTextView.text as NSString
        return 140 - text.length
    }
    
    
    
}
