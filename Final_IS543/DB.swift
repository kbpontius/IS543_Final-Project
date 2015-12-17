//
//  DB.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import Foundation
import SQLite

// Talk Table Columns
let talkTable = Table("conference_talk")
let talkID = Expression<Int>("TalkID")
let talkSessionID = Expression<Int>("SessionID")
let talkStartPageNum = Expression<Int>("StartPageNum")
let talkEndPageNum = Expression<Int>("EndPageNum")
let talkSequence = Expression<Int>("Sequence")

// Conference Table Columns
let confTable = Table("conference")
let confID = Expression<Int>("ID")
let confDescription = Expression<String?>("Description")
let confAbbreviation = Expression<String?>("Abbr")
let confYear = Expression<Int>("Year")
let confAnnual = Expression<String?>("Annual")
let confIssueDate = Expression<String?>("IssueDate")

class DB {
    // Singleton
    static let sharedInstance = DB()
    
    // Db connection information
    let DB_FILENAME = "core.23"
    let DB_EXTENSION = "db"
    let connection: Connection!
    
    // This prevents the init from being called multiple times
    private init() {
        connection = try! Connection(NSBundle.mainBundle().pathForResource(DB_FILENAME, ofType: DB_EXTENSION)!)
    }
    
    // MARK: - CONFERENCE METHODS
    
    func conferences() -> [String] {
        var conferences = [String]()
        
        for conferenceRecord in connection.prepare(confTable.order(confIssueDate)) {
            let conference = Conference(fromRow: conferenceRecord)
            conferences.append(conference.description)
        }
        
        // Reversed b/c I didn't want to spend time finding the proper predicate
        // call for that. Luckily Swift is awesome.
        return conferences.reverse()
    }
    
    // MARK: - TALK METHODS
    
    // Get all talks in DB
    func talksForConference(conferenceID: Int) -> [Talk] {
        var talks = [Talk]()
        
        for talk in connection.prepare(talkTable) {
            talks.append(Talk(fromRow: talk))
        }
        
        return talks
    }
}