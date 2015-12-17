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
let talkDate = Expression<String?>("Date")
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
    
    /**
        PLEASE NOTE: I recognize this is far from a good way to 
        do these DB calls, but after struggling with joins for 45 mins and
        other problems, I decided just to aggregate the data myself as a quick-n-dirty
        way to keep going. Sorry for the mess :)
    */
    func talksForConference(conferenceID: Int) -> [Talk] {
        var talks = [Talk]()
        var sessionIds = [Int]()
        var conferenceTalkIds = [Int]()
        
        let sessionIdentifiers = connection.prepare(sessionTable.filter(sessionConfID == conferenceID))
        
        for id in sessionIdentifiers {
            sessionIds.append(id.get(sessionID))
        }
        
        for sessionIdentifier in sessionIds {
            for id in connection.prepare(confTalkTable.filter(confTalkSessionID == sessionIdentifier)) {
                conferenceTalkIds.append(id.get(confTalkID))
            }
        }

        for conferenceTalkId in conferenceTalkIds {
            let talkRecord = connection.pluck(talkTable.filter(talkID == conferenceTalkId))
            let talk = Talk(fromRow: talkRecord!)
            talks.append(talk)
        }
        
        return talks
    }
    
    func talkNamesForConferenceId(conferenceId: Int) -> [String] {
        var talkNames = [String]()
        let talks = talksForConference(conferenceId)
        
        for talk in talks {
            talkNames.append(talk.title)
        }
        
        return talkNames
    }
    
    // Normally I'd use a query here and go off of talk ID...but there's 15 minutes left
    func talkWatchURL(conferenceId: Int, talkName: String) -> String {
        let talks = talksForConference(conferenceId)
        
        for talk in talks {
            if talk.title == talkName {
                return talk.watchURL
            }
        }
        
        return ""
    }
}
