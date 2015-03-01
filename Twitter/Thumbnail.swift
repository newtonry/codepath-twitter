//
//  Thumbnail.swift
//  Twitter
//
//  Created by Ryan Newton on 2/22/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class Thumbnail: UIImageView {
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
}
