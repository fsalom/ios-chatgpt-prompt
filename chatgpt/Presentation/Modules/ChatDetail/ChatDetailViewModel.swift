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
                                     content: chat.prompt,
                                     isFile: false))
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
        let loadingMessage = getLoadingAndSetMessageForUser(with: message,
                                                            isFile: false)
        setAndCall(with: message, for: loadingMessage.id)
        userNewMessage = ""
    }

    func send(this file: URL) {
        guard let text = try? String(contentsOf: file) else { return }
        let loadingMessage = getLoadingAndSetMessageForUser(with: text,
                                                            isFile: true)
        setAndCall(with: text, for: loadingMessage.id)
        userNewMessage = ""
    }

    func setAndCall(with message: String, for id: UUID) {
        Task {
            do {
                let gptmessage = try await useCase.sendToGPT(this: message,
                                                             with: messages,
                                                             for: chat.id)
                await replace(this: id, with: gptmessage)
            } catch {
                guard let GPTError = error as? GPTError else {
                    await replace(this: id, with: Message(error: "Unknown"))
                    return
                }
                switch GPTError {
                case .custom(let error, let code):
                    let errorMessage = Message(error: error)
                    if code == "context_length_exceeded" {
                        isFlushRequired = true
                    }
                    await replace(this: id, with: errorMessage)
                }
            }
        }
    }

    func getLoadingAndSetMessageForUser(with message: String, isFile: Bool) -> Message {
        self.messages.append(Message(role: "user",
                                     isSentByUser: true,
                                     state: .success,
                                     content: message,
                                     isFile: isFile))
        let loadingMessage = Message()
        messages.append(loadingMessage)
        return loadingMessage
    }

    func replace(this id: UUID, with message: Message) async {
        await MainActor.run {
            messages.removeAll(where: { $0.id == id })
            messages.append(message)
        }
    }
}
