//
//  ViewController.swift
//  JSON
//
//  Created by Gu on 2016/1/23.
//  Copyright © 2016年 ShuCunGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var randomUser = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func addRandomUserButton(sender: UIButton) {
        RestAPIManger.sharedInstance.getRandomUser { (json) -> Void in
            let results = json["results"]
            for (index, subJson):(String, JSON) in json {
                let user: AnyObject = subJson["user"].object
                self.randomUser.addObject(user)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.myTableView.reloadData()
                })
            }
        }
    }
    
    // table view
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomUser.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as? TableViewCell
        
        // 將陣列值轉JSON格式
        let user: JSON = JSON(self.randomUser[indexPath.row])
        
        let pictureURL = user["picture"]["medium"].string
        
        let url = NSURL(string: pictureURL!)
        
        let data = NSData(contentsOfURL: url!)
        
        cell?.textLabel?.text = user["username"].stringValue
        cell?.imageView?.image = UIImage(data: data!)
        
        
        return cell!
    }

}

