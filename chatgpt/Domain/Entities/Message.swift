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
    var content: String? = ""

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
        isSentByUser = coredata.isSentByUser
    }

    init(role: String,
         isSentByUser: Bool,
         state: MessageState,
         content: String){
        self.isSentByUser = isSentByUser
        self.state = state
        self.role = role
        self.content = content
    }
}
