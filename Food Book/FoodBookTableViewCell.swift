//
//  CustomCell.swift
//  Food Book
//
//  Created by Tihomir Videnov on 4/7/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width / 2
        thumbnailImageView.clipsToBounds = true
        // Initialization code
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
