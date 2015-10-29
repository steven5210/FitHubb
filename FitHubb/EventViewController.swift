//
//  EventViewController.swift
//  FitHubb
//
//  Created by Derek Nasawang on 10/29/15.
//  Copyright © 2015 Steven Huynh. All rights reserved.
//

import UIKit
import Alamofire

class EventViewController: UITableViewController {

    var events = ["Seattle"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(.GET, "http://fithubb.herokuapp.com/api/events")
            .responseJSON { response in
                debugPrint(response)
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell")!
        cell.textLabel?.text = events[indexPath.row]
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

}
