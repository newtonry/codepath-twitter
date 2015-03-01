//
//  BaseViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/28/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {    
    var menuViewController: MenuViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor(red: 0.333, green: 0.675, blue: 0.933, alpha: 1.0)
        setupMenuViewController()
    }
    
    func setupMenuViewController() {
        menuViewController = storyboard!.instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController
        
        var frame = self.view.frame
        frame.size.width = frame.width * 0.95
        
        menuViewController?.visibleFrame = frame
        frame.origin.x = frame.origin.x - frame.width
        menuViewController!.originalFrame = frame
        menuViewController!.view.frame = frame
        
        let panRightRecognizer = UIPanGestureRecognizer(target: self, action: "showHamburgerMenu:")
        self.view.addGestureRecognizer(panRightRecognizer)
        
        let panLeftRecognizer = UIPanGestureRecognizer(target: self, action: "hideHamburgerMenu:")
        menuViewController!.view.addGestureRecognizer(panLeftRecognizer)
        menuViewController!.view.alpha = 0
        menuViewController!.parentNavigationController = self.navigationController
        
        self.view.addSubview(menuViewController!.view)
    }
    
    func hideHamburgerMenu(sender: UIPanGestureRecognizer) {
        let isPanningRight = sender.velocityInView(view).x < -500
        
        if isPanningRight {
            UIView.animateWithDuration(0.2, animations: {
                self.menuViewController!.view.frame = self.menuViewController!.originalFrame!
            })
        }
    }
    
    func showHamburgerMenu(sender: UIPanGestureRecognizer) {
        let isPanningLeft = sender.velocityInView(view).x > 500

        if isPanningLeft {
            menuViewController!.view.alpha = 1
            UIView.animateWithDuration(0.2, animations: {
                self.menuViewController!.view.frame = self.menuViewController!.visibleFrame!
            })
        }
    }
}
