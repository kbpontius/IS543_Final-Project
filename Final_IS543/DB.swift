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
let confTalkTable = Table("conference_talk")
let confTalkID = Expression<Int>("TalkID")
let confTalkSessionID = Expression<Int>("SessionID")
let confTalkStartPageNum = Expression<Int>("StartPageNum")
let confTalkEndPageNum = Expression<Int>("EndPageNum")
let confTalkSequence = Expression<Int>("Sequence")

// Conference Table Columns
let confTable = Table("conference")
let confID = Expression<Int>("ID")
let confDescription = Expression<String?>("Description")
let confAbbreviation = Expression<String?>("Abbr")
let confYear = Expression<Int>("Year")
let confAnnual = Expression<String?>("Annual")
let confIssueDate = Expression<String?>("IssueDate")

// Session Table Columns
let sessionTable = Table("conf_session")
let sessionID = Expression<Int>("ID")
let sessionDescription = Expression<String?>("Description")
let sessionAbbreviation = Expression<String?>("Abbr")
let sessionDate = Expression<String?>("Date")
let sessionSequence = Expression<Int>("Sequence")
let sessionConfID = Expression<Int>("ConferenceID")

// Talk Table Columns
let talkTable = Table("talk")
let talkID = Expression<Int>("ID")
let talkCorpus = Expression<String?>("Corpus")
let talkURL = Expression<String?>("URL")
let talkTitle = Expression<String?>("Title")
let talkDate = Expression<String?>("TalkDate")
let talkSpeakerID = Expression<Int>("SpeakerID")
let talkListenURL = Expression<String?>("ListenURL")
let talkWatchURL = Expression<String?>("WatchURL")

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
    func talksForConference(conferenceID: Int) {
        let result = talkTable.join(confTalkTable.join(sessionTable, on: confTalkSessionID == sessionID), on: sessionConfID == conferenceID)
        
        print(result)
    }
}
