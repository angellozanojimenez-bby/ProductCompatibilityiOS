//
//  CompatibleProductTableViewCell.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/22/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit

class CompatibleProductTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var skuLabel: UILabel!
    @IBOutlet var manufacturerLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
