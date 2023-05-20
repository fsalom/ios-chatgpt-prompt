//
//  ChatRepository.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol ChatRepositoryProtocol {
    func getMessages(for chatID: String) async throws -> [Message]
    func getChats() async throws -> [Chat]
    func create(with name: String, image: Data?, prompt: String) async throws
    func send(this message: String, isSentByUser: Bool, to chatID: String) async throws
}

class ChatRepository: ChatRepositoryProtocol {
    var datasource: ChatDataSourceProtocol

    init(datasource: ChatDataSourceProtocol) {
        self.datasource = datasource
    }

    func getMessages(for chatID: String) async throws -> [Message] {
        return try await datasource.getMessages(for: chatID)
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        return try await datasource.create(with: name, image: image, prompt: prompt)
    }

    func getChats() async throws -> [Chat] {
        return try await datasource.getChats()
    }

    func send(this message: String, isSentByUser: Bool, to chatID: String) async throws {
        try await datasource.send(this: message, isSentByUser: isSentByUser, to: chatID)
    }
}
