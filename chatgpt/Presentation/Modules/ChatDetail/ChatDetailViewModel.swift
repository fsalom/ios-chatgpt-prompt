//
//  ChatDetailViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

class ChatDetailViewModel: ChatDetailViewModelProtocol {
    @Published var userNewMessage =  ""
    @Published var messages: [ChatMessage] = []

    var useCase: ChatUseCaseProtocol!

    init() {
        load()
    }

    func load() {
        Task {
            let messages = try await useCase.getMessages()
            self.messages.append(contentsOf: messages)
        }
    }

    func sendNewMessage() {
        self.messages.append(ChatMessage(isSentByUser: true, message: userNewMessage))
        userNewMessage = ""
    }
}
