//
//  UserViewController.swift
//  Twitter
//
//  Created by Ryan Newton on 2/26/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class UserViewController: BaseViewController {
    @IBOutlet weak var headerBackgroundImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    
//    private var startingPoint:
    private var usingGesture = false
    private var bannerStartFrame: CGRect?
    private var originalBannerImage: UIImage?
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance.getProfileBannerForUser(user!, completion: {( backgroundUrl: NSURL?, error: NSError?)-> Void in
            if (backgroundUrl != nil) {
                self.headerBackgroundImage.setImageWithURL(backgroundUrl!)
            }
            self.userImage.setImageWithURL(self.user?.profileImageHigh!)
            self.bannerStartFrame = self.headerBackgroundImage.frame
            self.originalBannerImage = self.headerBackgroundImage!.image
        })

        userImage.layer.cornerRadius = 6
        userImage.clipsToBounds = true
        
        
        self.followingCount.text = "\(user!.followingCount!)"
        self.followersCount.text = "\(user!.followersCount!)"
        self.tweetCount.text = "\(user!.tweetCount!)"
        
        setupPullRecognizer()

    }

    func setupPullRecognizer() {
        let recognizer = UIPanGestureRecognizer(target: self, action: "beingPulled:")
        self.view.addGestureRecognizer(recognizer)
    }
    
    func beingPulled(sender: UIPanGestureRecognizer) {
        let isPullingDown = sender.velocityInView(view).y > 500

        
        
        let point = sender.locationInView(self.view)
        let percent = fmaxf(fminf(Float(point.y / view.frame.height), 0.99), 0.0)
        
            switch (sender.state){
            case .Began:
                self.usingGesture = true
                
                
                
    //            self.transitioningController.navigationController?.popViewControllerAnimated(true)
            case .Changed:
//                println(CGFloat(percent))
//
//                var filterImage = CIImage(image: headerBackgroundImage.image!)
//                let filter = CIFilter(name: "CIGaussianBlur")
//                filter.setDefaults()
//                filter.setValue(filterImage, forKey: "inputImage")
//
//                filter.setValue(30, forKey: "inputRadius")
//                var outputImage = filter.valueForKey("outputImage") as CIImage
//                headerBackgroundImage.image = UIImage(CIImage: outputImage)

                
                
                let image = CIImage(CGImage: headerBackgroundImage.image!.CGImage)
                let filter = CIFilter(name: "CIGaussianBlur")
                filter.setDefaults()
                filter.setValue(5, forKey: "inputRadius")
                filter.setValue(image, forKey: kCIInputImageKey)
                
                let context = CIContext(options: nil)
                let imageRef = context.createCGImage(filter.outputImage, fromRect: image.extent())
                headerBackgroundImage.image = UIImage(CGImage: imageRef)
                
                
                
                
                
                
                
                
                
                
                
                
                println(headerBackgroundImage.frame.width * 1.5)
                
            case .Ended, .Cancelled:
                if percent > 0.5 {
                    headerBackgroundImage.image = originalBannerImage!

//                var cgImage = ciContext.createCGImage(ciFilter.outputImage, fromRect: ciImage.extent())

                    
                    
                    
                    
                    
                    
    //                self.finishInteractiveTransition()
                } else {
    //                self.cancelInteractiveTransition()
                }
//                headerBackgroundImage.frame = bannerStartFrame!
                self.usingGesture = false

            default:
                NSLog("Unhandled state")
            }

        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}
