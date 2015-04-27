//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingsViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var feedData: NSArray?
    var filteredFeed = NSMutableArray()
    var filterString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        
        reload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        FBRequestConnection.startWithGraphPath("/rdio/feed", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            self.feedData = result["data"] as? NSArray
            self.filterFeed()
        }
    }
    
    func filterFeed() {
        filteredFeed.removeAllObjects()
        if let stories = feedData {
            for story in stories {
                let type=story["type"]
                println("\(type)")
                if let message = story["message"] as? String {
                    if let filter = filterString {
                        if filter == story["type"] as! String {
                            filteredFeed.addObject(story)
                        }
                    } else {
                        filteredFeed.addObject(story)
                    }
                }
            }
        }
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFeed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if let feedItem = filteredFeed[indexPath.row] as? NSDictionary {
            if let message = feedItem["message"] as? String {
                if let picture = feedItem["picture"] as? String {
                    var cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
                    cell.photoImageView.setImageWithURL(NSURL(string: picture))
                    cell.messageLabel.text = message
                    return cell
                } else {
                    var cell = tableView.dequeueReusableCellWithIdentifier("StatusCell", forIndexPath: indexPath) as! StatusCell
                    cell.messageLabel.text = message
                    return cell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    func settingsViewController(settingsViewController: SettingsViewController, settingsChanged newSetting: String?) {
        filterString = newSetting?.lowercaseString
        
        self.filterFeed()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var navController = segue.destinationViewController as! UINavigationController
        var vc = navController.topViewController as! SettingsViewController
        vc.delegate = self
    }


}
