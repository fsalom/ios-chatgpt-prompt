//
//  ChatDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol ChatDataSourceProtocol {
    func getMessages() async throws -> [Message]
    func getChats() async throws -> [Chat]
}


class ChatDataSource: ChatDataSourceProtocol {
    func getMessages() async throws -> [Message] {
        return [Message(role: "user", isSentByUser: true, state: .success, content: "Hola Chat"),
                Message(role: "user", isSentByUser: false, state: .success, content: "Hola Fer"),
                Message(role: "user", isSentByUser: true, state: .success, content: "Cuanto es 1 + 1?"),
                Message(role: "user", isSentByUser: false, state: .success, content: "el resultado es 2")]
    }

    func getChats() async throws -> [Chat] {
        return [Chat(name: "Fernando Salom",
                     online: true,
                     profileImage: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80",
                     lastUpdated: "10:01",
                     lastMessage: "message"),
                Chat(name: "Fernando Salom",
                     online: false,
                     profileImage: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80",
                     lastUpdated: "12:02",
                     lastMessage: "message")]
    }
}
