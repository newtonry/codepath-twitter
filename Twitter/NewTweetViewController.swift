//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/21/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit


class NewTweetViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var userImage: Thumbnail!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var remainingLabel: UILabel!
    var preText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.translucent = false

        fillUserDetails()
        User.currentUser?.profileImageUrl
        tweetTextView.becomeFirstResponder()
        remainingLabel.text = "\(lettersLeft()) remaining"
        self.tweetTextView.delegate = self
        
        if let pt = preText {
            self.tweetTextView.text = pt
        }
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
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as UINavigationController!
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        let status = tweetTextView.text
        TwitterClient.sharedInstance.postTweetWithStatus(status, completion: {(response: AFHTTPRequestOperation?, error: NSError?) -> Void in
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigationController") as UINavigationController!
            self.presentViewController(vc, animated: true, completion: nil)
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
