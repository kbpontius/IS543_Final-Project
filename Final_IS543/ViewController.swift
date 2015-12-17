//
//  ViewController.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testDB()
    }
    
    private func testDB() {
        let connection = DB.sharedInstance.connection
        
        let bookTable = Table("book")
        let books = connection.prepare(bookTable)
        
        let id = Expression<Int64>("ID")
        let fullName = Expression<String?>("FullName")
        let gridName = Expression<String?>("GridName")
        let citationCount = Expression<Int64>("CitationCount")
        
        for book in books {
            print("id: \(book[id]), Full Name: \(book[fullName]), Grid Name: \(book[gridName]), Citation Count: \(book[citationCount])")
        }
        
        print("Finished.")
    }
}

