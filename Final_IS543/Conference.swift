//
//  Conference.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import Foundation
import SQLite

class Conference {
    let id: Int
    let description: String
    let abbreviation: String
    let year: Int
    let annual: String
    let issueDate: String
    
    init(fromRow: Row) {
        id = fromRow.get(confID)
        description = fromRow.get(confDescription) ?? ""
        abbreviation = fromRow.get(confAbbreviation) ?? ""
        year = fromRow.get(confYear)
        annual = fromRow.get(confAnnual) ?? ""
        issueDate = fromRow.get(confIssueDate) ?? ""
    }
}