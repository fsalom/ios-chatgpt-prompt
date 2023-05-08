//
//  Message.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

struct ChatItem: Identifiable {
    let id = UUID()
    let isSentByUser: Bool
    var message: String
}
