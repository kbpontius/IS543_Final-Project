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
    var conferenceID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        db.talksForConference(147)
    }
    
    // MARK: - SETUP METHODS
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - TABLEVIEW DELEGATE METHODS
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
//        cell.textLabel?.text = db.talksForConference(3)
//        
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return db.talksForConference(3).count
//    }
}
