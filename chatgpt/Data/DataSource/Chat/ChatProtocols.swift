//
//  ChatProtocols.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 20/5/23.
//

import Foundation

protocol ChatDataSourceProtocol {
    func getMessages(for chatID: String) async throws -> [Message]
    func getChats() async throws -> [Chat]
    func getChat(with id: String) async throws -> Chat
    func create(with name: String, image: Data?, prompt: String) async throws
    func edit(this chat: Chat) async throws
    func send(this message: Message, to chatID: String) async throws
    func clean(this chat: Chat) throws
}
