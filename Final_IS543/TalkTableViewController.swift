//
//  TalkTableViewController.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import UIKit

class TalkTableViewController: UITableViewController {
    let db = DB.sharedInstance
    var conferenceID: Int!
    var talkNames: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        talkNames = db.talkNamesForConferenceId(conferenceID!)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - SETUP METHODS
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - NAVIGATION METHODS
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueShowVideo" {
            let watchURL = db.talkWatchURL(conferenceID!, talkName: talkNames[tableView.indexPathForSelectedRow!.row])
            let destVC = segue.destinationViewController as! VideoViewController
            destVC.watchURL = watchURL
        }
    }
    
    // MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = talkNames[indexPath.row]
    
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talkNames.count
    }
}
