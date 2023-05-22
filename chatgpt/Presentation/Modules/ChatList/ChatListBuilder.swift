//
//  ChatBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation
import TripleA

class ChatListBuilder {
    func build() -> ChatListView<ChatListViewModel> {
        let datasource = ChatCoreDataSource(context: PersistenceController.shared.container.viewContext)
        let repository = ChatRepository(datasource: datasource)

        let useCase = ChatUseCase(chatRepository: repository)
        
        let viewModel = ChatListViewModel(useCase: useCase)
        let view = ChatListView(viewModel: viewModel)
        return view
    }
}

