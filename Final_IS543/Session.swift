//
//  Session.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import Foundation
import SQLite

class Session {
    let id: Int
    let description: String
    let abbreviation: String
    let date: String
    let sequence: Int
    let confID: Int
    
    init(fromRow: Row) {
        id = fromRow.get(sessionID)
        description = fromRow.get(sessionDescription) ?? ""     // Empty by default.
        abbreviation = fromRow.get(sessionAbbreviation) ?? ""
        date = fromRow.get(sessionDate) ?? ""
        sequence = fromRow.get(sessionSequence)
        confID = fromRow.get(sessionConfID)
    }
}