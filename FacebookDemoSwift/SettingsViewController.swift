//
//  SettingsViewController.swift
//  FacebookDemoSwift
//
//  Created by Chris Beale on 4/26/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate : class {
   func  settingsViewController(settingsViewController: SettingsViewController, settingsChanged newSetting: String?)
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: SettingsViewControllerDelegate?
    
    let settings = ["Links", "Statuses", "Photos", "Videos"]
    let settingTypes = ["link", "status", "photo", "video"]
    var settingIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onApplyPressed(sender: AnyObject) {
        
        var setting:String? = settingIndex > 0 ? settingTypes[settingIndex] : nil
        delegate?.settingsViewController(self, settingsChanged: setting)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onClosePressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell", forIndexPath: indexPath) as! SettingsCell
        
        cell.titleLabel.text = settings[indexPath.row]
        cell.delegate = self
        cell.settingSwitch.on = settingIndex == indexPath.row
        
        return cell
    }
    
    func settingsCell(settingsCell: SettingsCell, switchValueChanged value: Bool) {
        if let indexPath = tableView.indexPathForCell(settingsCell) {
            settingIndex = value ? indexPath.row : -1
        }
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
