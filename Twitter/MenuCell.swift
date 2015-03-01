//
//  MenuCell.swift
//  Twitter
//
//  Created by Ryan Newton on 2/27/15.
//  Copyright (c) 2015 ___rvkn___. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
