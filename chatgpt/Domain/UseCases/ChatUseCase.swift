//
//  ChatUseCase.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation


protocol ChatUseCaseProtocol {
    func getMessages() async throws -> [ChatMessage]
}

class ChatUseCase: ChatUseCaseProtocol {
    var repository: ChatRepositoryProtocol

    init(repository: ChatRepositoryProtocol) {
        self.repository = repository
    }

    func getMessages() async throws -> [ChatMessage] {
        try await repository.getMessages()
    }
}
