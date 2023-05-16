//
//  ChatRepository.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol ChatRepositoryProtocol {
    func getMessages() async throws -> [Message]
    func getChats() async throws -> [Chat]
    func create(with name: String, image: Data?, prompt: String) async throws
}

class ChatRepository: ChatRepositoryProtocol {
    var datasource: ChatDataSourceProtocol

    init(datasource: ChatDataSourceProtocol) {
        self.datasource = datasource
    }

    func getMessages() async throws -> [Message] {
        return try await datasource.getMessages()
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        return try await datasource.create(with: name, image: image, prompt: prompt)
    }

    func getChats() async throws -> [Chat] {
        return try await datasource.getChats()
    }
}
