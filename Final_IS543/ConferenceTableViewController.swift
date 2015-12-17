//
//  ViewController.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import UIKit
import SQLite

class ConferenceTableViewController: UITableViewController {
    let db = DB.sharedInstance
    let NUM_OF_CONFERENCES = 147 // Quick way to find conference ID
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - SETUP METHODS
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - NAVIGATION METHODS
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SegueToConference" {
            let destVC = segue.destinationViewController as! TalkTableViewController
            destVC.conferenceID = NUM_OF_CONFERENCES - tableView.indexPathForSelectedRow!.row
        }
    }
    
    // MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = db.conferences()[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.conferences().count
    }
}