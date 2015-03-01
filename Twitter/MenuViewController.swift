//
//  MenuViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/27/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct MenuItemStruct {
        var title: String
        var action: () -> Void
        var image: String
    }
    
    var parentNavigationController: UINavigationController?
    
    
    var originalFrame: CGRect?
    var visibleFrame: CGRect?
    
    var menuItems: [MenuItemStruct]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScreenname: UILabel!
    @IBOutlet weak var profileView: UIView!
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuItems = [
            MenuItemStruct(title: "Profile", action: switchToProfileViewController, image: "profile.png"),
            MenuItemStruct(title: "Timeline", action: switchToHomeViewController, image: "home.png"),
            MenuItemStruct(title: "Mentions", action: switchToMentionViewController, image: "mentions.png")
        ]
  
        
        self.view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.9)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 66
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        profileView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

        userImage.setImageWithURL(User.currentUser?.profileImageHigh)
        userImage.layer.cornerRadius = 12
        userImage.clipsToBounds = true
        
        userName.text = User.currentUser!.name!
        userScreenname.text = "@\(User.currentUser!.screenname!)"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as MenuCell
        let menuItem = menuItems![indexPath.row]
        
        cell.cellTitle.text = menuItem.title
        cell.thumbnail.image = UIImage(named: menuItem.image)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems!.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let menuItem = menuItems![indexPath.row]

        menuItem.action()
    }
    
    func switchToProfileViewController() {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("UserViewController") as UserViewController!
        vc.user = User.currentUser
        self.parentNavigationController!.pushViewController(vc, animated: true)
        
    }

    func switchToHomeViewController() {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as TweetViewController!
        self.parentNavigationController!.pushViewController(vc, animated: true)
    }
    
    func switchToMentionViewController() {
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("TweetsViewController") as TweetViewController!
        // This is a pretty hacky way of doing it, it should really be its own class, but whatever works for now
        vc.tweetGatheringMethod = TwitterClient.sharedInstance.mentionsTimelineEndpointWithCompletion
        self.parentNavigationController!.pushViewController(vc, animated: true)
    }

}
