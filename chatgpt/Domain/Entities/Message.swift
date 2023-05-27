//
//  Message.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

enum MessageState {
    case loading
    case error
    case success
    case file
}

struct MessageContent {
    enum MessageType {
        case text
        case code
    }
    var text: String
    var type: MessageType
}

class Message: Identifiable, Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.id == rhs.id
    }

    let id = UUID()
    let isSentByUser: Bool
    var state: MessageState
    var role: String
    var createdAt: Date = Date()
    var content: String? = ""
    var isFile: Bool = false

    init(dto: MessageDTO) {
        role = dto.role
        content = dto.content
        state = .success
        isSentByUser = false
    }

    init(coredata: ChatMessageCD) {
        role = coredata.role
        content = coredata.content
        state = .success
        createdAt = coredata.createdAt
        isSentByUser = coredata.isSentByUser
        state = isFile(this: coredata.content) ? .file : self.state
    }

    init(role: String,
         isSentByUser: Bool,
         state: MessageState,
         createdAt: Date = Date(),
         content: String){
        self.isSentByUser = isSentByUser
        self.state = state
        self.role = role
        self.content = content
        self.state = isFile(this: content) ? .file : self.state
    }

    func isFile(this text: String) -> Bool {
        let characters: [Character] = [",", ";"]
        for character in characters {
            if text.filter({ $0 == character }).count > 6 {
                return true
            }
        }
        return false
    }
}
