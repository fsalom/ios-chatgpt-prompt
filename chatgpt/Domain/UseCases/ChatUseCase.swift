//
//  ChatUseCase.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation


protocol ChatUseCaseProtocol {
    func getMessages(for chatID: String) async throws -> [Message]
    func getChats() async throws -> [Chat]
    func sendToGPT(this message: String,
                   with context: [Message],
                   for chatID: String) async throws -> Message
    func create(with name: String, image: Data?, prompt: String) async throws
}

class ChatUseCase: ChatUseCaseProtocol {
    var chatRepository: ChatRepositoryProtocol
    var gptRepository: GPTRepositoryProtocol?

    init(chatRepository: ChatRepositoryProtocol, gptRepository: GPTRepositoryProtocol? = nil) {
        self.chatRepository = chatRepository
        self.gptRepository = gptRepository
    }

    func getMessages(for chatID: String) async throws -> [Message] {
        try await chatRepository.getMessages(for: chatID)
    }

    func getChats() async throws -> [Chat] {
        try await chatRepository.getChats()
    }

    func sendToGPT(this message: String,
                   with context: [Message],
                   for chatID: String) async throws -> Message {
        let messages = context.map { message in
            MessageDTO(from: message)
        }
        try await chatRepository.send(this: message,
                                      isSentByUser: true,
                                      to: chatID)
        if let message = try await gptRepository?.send(this: message,
                                                       and: messages) {
            try await chatRepository.send(this: message.content,
                                          isSentByUser: false,
                                          to: chatID)
            return Message(dto: message)
        }
        return Message(role: "assistant", isSentByUser: false, state: .error, content: "Error")
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        try await chatRepository.create(with: name, image: image, prompt: prompt)
    }
}
