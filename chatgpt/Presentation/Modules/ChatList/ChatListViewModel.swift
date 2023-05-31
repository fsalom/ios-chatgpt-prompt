//
//  ChatViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation
import CoreData

class ChatListViewModel: ObservableObject, ChatListViewModelProtocol {
    @Published var chats: [Chat]
    
    var useCase: ChatUseCaseProtocol!

    init(useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
        self.chats = []
    }
    
    func load() {
        Task {
            let chats = try await useCase.getChats()

            await MainActor.run {
                self.chats = chats
            }
        }
    }
}
