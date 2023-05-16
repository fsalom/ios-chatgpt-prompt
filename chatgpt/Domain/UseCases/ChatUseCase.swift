//
//  ChatUseCase.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation


protocol ChatUseCaseProtocol {
    func getMessages() async throws -> [Message]
    func getChats() async throws -> [Chat]
    func sendToGPT(this message: String, with context: [Message]) async throws -> Message
    func create(with name: String, image: Data?, prompt: String) async throws
}

class ChatUseCase: ChatUseCaseProtocol {
    var chatRepository: ChatRepositoryProtocol
    var gptRepository: GPTRepositoryProtocol?

    init(chatRepository: ChatRepositoryProtocol, gptRepository: GPTRepositoryProtocol? = nil) {
        self.chatRepository = chatRepository
        self.gptRepository = gptRepository
    }

    func getMessages() async throws -> [Message] {
        try await chatRepository.getMessages()
    }

    func getChats() async throws -> [Chat] {
        try await chatRepository.getChats()
    }

    func sendToGPT(this message: String, with context: [Message]) async throws -> Message {
        let messages = context.map { message in
            MessageDTO(from: message)
        }
        if let message = try await gptRepository?.send(this: message,
                                                       and: messages) {
            return Message(dto: message)
        }
        return Message(role: "assistant", isSentByUser: false, state: .error, content: "Error")
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        try await chatRepository.create(with: name, image: image, prompt: prompt)
    }
}
