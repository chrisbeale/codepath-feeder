//
//  StatusCell.swift
//  FacebookDemoSwift
//
//  Created by Chris Beale on 4/26/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class StatusCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageLabel.preferredMaxLayoutWidth = messageLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
