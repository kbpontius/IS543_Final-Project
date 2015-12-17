//
//  ViewController.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import UIKit
import SQLite

class TalkTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - SETUP METHODS
    
    private func setupTableView() {
        tableView.delegate = self
    }
    
    // MARK: - TABLEVIEW DELEGATE METHODS
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
    }
}