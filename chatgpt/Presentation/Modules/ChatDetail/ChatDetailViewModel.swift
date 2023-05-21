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
    var chat: Chat

    init(with chat: Chat, and useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
        self.chat = chat
        self.messages.append(Message(role: "user",
                                     isSentByUser: true,
                                     state: .success,
                                     createdAt: chat.lastUpdated,
                                     content: chat.prompt))        
    }

    func load() {
        Task {
            let messages = try await useCase.getMessages(for: chat.id)
            self.messages.append(contentsOf: messages)
        }
    }

    func send(this message: String) {
        self.messages.append(Message(role: "user",
                                     isSentByUser: true,
                                     state: .success,
                                     content: message))
        let newMessage = Message(role: "assistant",
                              isSentByUser: false,
                              state: .loading,
                              content: "")
        messages.append(newMessage)
        Task {
            do {
                let gptmessage = try await useCase.sendToGPT(this: message,
                                                             with: messages,
                                                             for: chat.id)
                await MainActor.run {
                    messages.removeAll(where: { $0.id == newMessage.id })                    
                    messages.append(gptmessage)
                }
            } catch {
                messages.removeAll(where: { $0.id == newMessage.id })
                let errorMessage = Message(role: "assistant",
                                      isSentByUser: false,
                                      state: .error,
                                      content: "")
                messages.append(errorMessage)
            }
        }
        userNewMessage = ""
    }
}
