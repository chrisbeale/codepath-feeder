//
//  SettingsCell.swift
//  FacebookDemoSwift
//
//  Created by Chris Beale on 4/26/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol SettingsCellDelegate : class {
    func settingsCell(settingsCell: SettingsCell, switchValueChanged value: Bool)
}

class SettingsCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    weak var delegate: SettingsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchChanged(sender: AnyObject) {
        delegate?.settingsCell(self, switchValueChanged: settingSwitch.on)
    }
}
