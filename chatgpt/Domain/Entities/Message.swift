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
    var filename: String? = ""
    var isFile: Bool = false

    init(role: String, content: String){
        self.role = role
        self.content = content
        state = .success
        isSentByUser = false
    }

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
        isFile = coredata.isFile
        filename = coredata.filename
        state = isFile ? .file : self.state
    }

    init(role: String,
         isSentByUser: Bool,
         state: MessageState,
         createdAt: Date = Date(),
         content: String,
         filename: String? = "",
         isFile: Bool = false){
        self.isSentByUser = isSentByUser
        self.state = state
        self.role = role
        self.content = content
        self.filename = filename
        self.state = isFile ? .file : self.state
        self.isFile = isFile
    }

    /// Error init
    init(error: String) {
        self.role = "assistant"
        self.isSentByUser = false
        self.state =  .error
        self.content = error
        self.isFile = false
    }

    /// Loading init
    init() {
        self.role = "assistant"
        self.isSentByUser = false
        self.state =  .loading
        self.content = ""
        self.isFile = false
    }
}
