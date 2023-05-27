//
//  ChatDetailViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

class ChatDetailViewModel: ChatDetailViewModelProtocol {
    @Published var userNewMessage =  ""
    @Published var isFlushRequired = false
    @Published var messages: [Message]

    var useCase: ChatUseCaseProtocol!
    var chat: Chat

    init(with chat: Chat, and useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
        self.chat = chat
        self.messages = []
        self.messages.append(Message(role: "user",
                                     isSentByUser: true,
                                     state: .success,
                                     createdAt: chat.createdAt,
                                     content: chat.prompt))
    }

    func clean() {
        Task {
            try? useCase.clean(this: chat)
            await MainActor.run {
                self.messages = []
            }
        }
    }

    func load() {
        Task {
            let messages = try await useCase.getMessages(for: chat.id)
            await MainActor.run {
                self.messages.append(contentsOf: messages)
            }
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
                await MainActor.run {
                    messages.removeAll(where: { $0.id == newMessage.id })
                    guard let GPTError = error as? GPTError else { return }
                    switch GPTError {
                    case .custom(let string, let code):
                        let errorMessage = Message(role: "assistant",
                                                   isSentByUser: false,
                                                   state: .error,
                                                   content: string)
                        if code == "context_length_exceeded" {
                            isFlushRequired = true
                        }
                        messages.append(errorMessage)
                    }

                }
            }
        }
        userNewMessage = ""
    }
}
