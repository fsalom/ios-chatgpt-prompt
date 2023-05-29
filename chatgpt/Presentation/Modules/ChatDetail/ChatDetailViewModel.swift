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
    var prompt: Message

    init(with chat: Chat, and useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
        self.chat = chat
        self.messages = []
        self.prompt = Message(role: "user",
                              isSentByUser: true,
                              state: .success,
                              createdAt: chat.createdAt,
                              content: chat.prompt,
                              isFile: false)
    }

    func clean() {
        Task {
            try? useCase.clean(this: chat)
            await MainActor.run {
                self.messages.removeAll()
                self.messages.append(self.prompt)
            }
        }
    }

    func load() {
        Task {
            let messages = try await useCase.getMessages(for: chat.id)
            await MainActor.run {
                self.messages.removeAll()
                self.messages.append(self.prompt)
                self.messages.append(contentsOf: messages)
            }
        }
    }

    func getDocuments() -> [Message] {
        return self.messages.filter({ $0.isFile })
    }

    func send(this message: String) {
        let (loadingMessage, message) = getLoadingAndSetMessageForUser(with: message,
                                                                       isFile: false)
        setAndCall(with: message, for: loadingMessage.id)
        userNewMessage = ""
    }

    func send(this file: URL) {
        if file.startAccessingSecurityScopedResource() {
            guard let text = try? String(contentsOf: file) else { return }
            let filename = file.pathComponents.last
            let (loadingMessage, message) = getLoadingAndSetMessageForUser(with: text,
                                                                           and: filename,
                                                                           isFile: true)
            setAndCall(with: message, for: loadingMessage.id)
            userNewMessage = ""
        }
        file.stopAccessingSecurityScopedResource()
    }

    func setAndCall(with message: Message, for id: UUID) {
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
                    await replace(this: id, with: errorMessage, and: code)
                }
            }
        }
    }

    func getLoadingAndSetMessageForUser(with message: String, and filename: String? = "", isFile: Bool) -> (Message, Message) {
        let newMessage = Message(role: "user",
                                 isSentByUser: true,
                                 state: .success,
                                 content: message,
                                 filename: filename,
                                 isFile: isFile)
        let loadingMessage = Message()
        self.messages.append(newMessage)
        self.messages.append(loadingMessage)
        return (loadingMessage, newMessage)
    }

    func replace(this id: UUID, with message: Message, and code: String? = "") async {
        await MainActor.run {
            isFlushRequired = code == "context_length_exceeded" ? true : false
            messages.removeAll(where: { $0.id == id })
            messages.append(message)
        }
    }
}
