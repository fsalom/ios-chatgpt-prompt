//
//  ChatMessage.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let isSentByUser: Bool
    var message: String

    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.id == rhs.id
    }

}
