//
//  ChatViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

class ChatListViewModel: ObservableObject, ChatListViewModelProtocol {
    var chatItems: [Chat] = []

    var useCase: ChatUseCaseProtocol!

    init(useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
        load()
    }

    func load() {
        Task {
            let chats = try await useCase.getChats()
            self.chatItems.append(contentsOf: chats)
        }
    }
}
