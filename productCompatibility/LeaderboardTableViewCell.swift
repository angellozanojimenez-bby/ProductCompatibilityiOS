//
//  LeaderboardTableViewCell.swift
//  productCompatibility
//
//  Created by Lozano Jimenez, Angel on 7/27/16.
//  Copyright © 2016 Best Buy, Inc. All rights reserved.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    @IBOutlet var employeeID: UILabel!
    @IBOutlet var employeeScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
