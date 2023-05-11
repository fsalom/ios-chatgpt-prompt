//
//  ChatRepository.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol ChatRepositoryProtocol {
    func getMessages() async throws -> [ChatMessage]
    func getChats() async throws -> [Chat]
}

class ChatRepository: ChatRepositoryProtocol {
    var datasource: ChatDataSourceProtocol

    init(datasource: ChatDataSourceProtocol) {
        self.datasource = datasource
    }

    func getMessages() async throws -> [ChatMessage] {
        return try await datasource.getMessages()
    }

    func getChats() async throws -> [Chat] {
        return try await datasource.getChats()
    }
}
