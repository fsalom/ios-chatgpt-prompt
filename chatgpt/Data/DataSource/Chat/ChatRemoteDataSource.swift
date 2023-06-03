//
//  ChatDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation
import CoreData

class ChatDataSource: ChatDataSourceProtocol {
    func send(this message: Message, to chatID: String) async throws { }

    func getMessages(for chatID: String) async throws -> [Message] { return [] }

    func create(with name: String, image: Data?, prompt: String) async throws { }

    func edit(this chat: Chat) async throws { }

    func getChats() async throws -> [Chat] { return [] }

    func getChat(with id: String) async throws -> Chat { return Chat(profileImage: Data(),
                                                                     name: "",
                                                                     id: "",
                                                                     prompt: "",
                                                                     updatedAt: Date(),
                                                                     createdAt: Date()) }

    func clean(this chat: Chat) { }
}
