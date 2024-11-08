//
//  chay.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 11/3/24.
//

import Foundation

struct Chat {
    let chatID: String
    let lastMessageTimestamp: Date?
    
    init(chatID: String, lastMessageTimestamp: Date?) {
        self.chatID = chatID
        self.lastMessageTimestamp = lastMessageTimestamp
    }
}
