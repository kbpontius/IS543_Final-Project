//
//  Talk.swift
//  Final_IS543
//
//  Created by Kyle on 12/17/15.
//  Copyright © 2015 Kyle Pontius. All rights reserved.
//

import Foundation
import SQLite

class Talk {
    let id: Int
    let URL: String
    let title: String
    let date: String
    let speakerID: Int
    let listenURL: String
    let watchURL: String
    
    init(fromRow: Row) {
        id = fromRow.get(talkID)
        URL = fromRow.get(talkURL) ?? ""    // Blank by default
        title = fromRow.get(talkTitle) ?? ""
        date = fromRow.get(talkDate) ?? ""
        speakerID = fromRow.get(talkSpeakerID)
        listenURL = fromRow.get(talkListenURL) ?? ""
        watchURL = fromRow.get(talkWatchURL) ?? ""
    }
}