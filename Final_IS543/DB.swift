//
//  DB.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import Foundation
import SQLite

// Singleton
class DB {
    static let sharedInstance = DB()
    
    let DB_FILENAME = "core.23"
    let DB_EXTENSION = "db"
    let connection: Connection!
    
    // This prevents the init from being called multiple times.
    private init() {
        connection = try! Connection(NSBundle.mainBundle().pathForResource(DB_FILENAME, ofType: DB_EXTENSION)!)
    }
}