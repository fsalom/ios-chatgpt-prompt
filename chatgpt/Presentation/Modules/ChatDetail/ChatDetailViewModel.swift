//
//  ChatDetailViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

class ChatDetailViewModel: ChatDetailViewModelProtocol {
    @Published var userNewMessage =  ""
    @Published var messages: [Message] = []

    var useCase: ChatUseCaseProtocol!

    init(useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
        load()
    }

    func load() {
        Task {
            let messages = try await useCase.getMessages()
            self.messages.append(contentsOf: messages)
        }
    }

    func sendNewMessage() {
        self.messages.append(Message(role: "user", isSentByUser: true, state: .success, content: userNewMessage))
        Task {
            do {
                let message = try await useCase.sendToGPT(this: "enviado a chat GPT", with: messages)
                messages.append(message)
            } catch {

            }
        }
        userNewMessage = ""
    }
}
