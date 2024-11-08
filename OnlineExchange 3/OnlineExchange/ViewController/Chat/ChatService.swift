//
//  ChatService.swift
//  OnlineExchange
//
//  Created by Kumar Chandu on 11/3/24.
//

import FirebaseFirestore

class ChatService {
    private let db = Firestore.firestore()

    func fetchChats(completion: @escaping ([Chat]) -> Void) {
        db.collection("chats")
            .order(by: "lastMessageTimestamp", descending: true) // Sort by last message timestamp
            .getDocuments { (snapshot, error) in
                guard let documents = snapshot?.documents, error == nil else {
                    print("Error fetching documents: \(error?.localizedDescription ?? "Unknown error")")
                    completion([])
                    return
                }
                
                let chats = documents.compactMap { document -> Chat? in
                    let data = document.data()
                    let chatID = document.documentID
                    let lastMessageTimestamp = data["lastMessageTimestamp"] as? Timestamp
                    let lastMessageDate = lastMessageTimestamp?.dateValue() // Convert Timestamp to Date
                    
                    return Chat(chatID: chatID, lastMessageTimestamp: lastMessageDate)
                }
                
                completion(chats)
            }
    }
}
