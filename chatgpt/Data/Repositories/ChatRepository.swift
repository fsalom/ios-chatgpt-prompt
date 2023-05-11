//
//  ChatRepository.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol ChatRepositoryProtocol {
    func getMessages() async throws -> [ChatMessage]
}

class ChatRepository: ChatRepositoryProtocol {
    var datasource: ChatDataSourceProtocol

    init(datasource: ChatDataSourceProtocol) {
        self.datasource = datasource
    }

    func getMessages() async throws -> [ChatMessage] {
        return try await datasource.getMessages()
    }
}
