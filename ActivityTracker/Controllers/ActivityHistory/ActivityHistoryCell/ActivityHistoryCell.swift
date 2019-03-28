//
//  ActivityHistoryCell.swift
//  ActivityTracker
//
//  Created by Vijith TV on 28/03/19.
//  Copyright © 2019 Vijith. All rights reserved.
//

import UIKit

class ActivityHistoryCell: UITableViewCell {
    @IBOutlet weak var avgSpeedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
