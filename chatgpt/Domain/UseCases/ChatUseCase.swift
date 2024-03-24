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
    func getChat(with id: String) async throws -> Chat
    func sendToGPT(this message: Message,
                   with context: [Message],
                   for chatID: String) async throws -> Message
    func create(with name: String, image: Data?, prompt: String) async throws
    func edit(this chat: Chat) async throws
    func clean(this chat: Chat) throws
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

    func getChat(with id: String) async throws -> Chat {
        try await chatRepository.getChat(with: id)
    }

    func sendToGPT(this message: Message,
                   with context: [Message],
                   for chatID: String) async throws -> Message {
        let messages = context.map { message in
            MessageDTO(from: message)
        }
        try await chatRepository.send(this: message,
                                      to: chatID)
        if let message = try await gptRepository?.send(this: message.content ?? "",
                                                       and: messages) {
            try await chatRepository.send(this: message,
                                          to: chatID)
            return message
        }
        return Message(error: "Call to GPT failed")
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        try await chatRepository.create(with: name, image: image, prompt: prompt)
    }

    func edit(this chat: Chat) async throws {
        try await chatRepository.edit(this: chat)        
    }

    func clean(this chat: Chat) throws {
        try chatRepository.clean(this: chat)
    }
}
