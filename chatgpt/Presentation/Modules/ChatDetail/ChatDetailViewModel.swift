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
        let message = Message(role: "assistant", isSentByUser: false, state: .loading, content: "")
        messages.append(message)
        Task {
            do {
                let gptmessage = try await useCase.sendToGPT(this: "enviado a chat GPT", with: messages)
                await MainActor.run {
                    messages.removeAll(where: { $0.id == message.id })                    
                    messages.append(gptmessage)
                }
            } catch {

            }
        }
        userNewMessage = ""
    }
}
