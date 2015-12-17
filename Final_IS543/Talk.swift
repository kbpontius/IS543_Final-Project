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
    let session: Int
    let startPage: Int
    let endPage: Int
    let sequence: Int
    
    init(fromRow: Row) {
        id = fromRow.get(talkID)
        session = fromRow.get(talkSessionID)
        startPage = fromRow.get(talkStartPageNum)
        endPage = fromRow.get(talkEndPageNum)
        sequence = fromRow.get(talkSequence)
    }
}