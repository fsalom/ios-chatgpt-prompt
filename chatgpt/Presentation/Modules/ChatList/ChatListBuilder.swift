//
//  ChatBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

class ChatListBuilder {
    func build() -> ChatListView<ChatListViewModel> {
        let datasource = ChatDataSource()
        let repository = ChatRepository(datasource: datasource)
        let useCase = ChatUseCase(repository: repository)
        
        let viewModel = ChatListViewModel(useCase: useCase)
        let view = ChatListView(viewModel: viewModel)
        return view
    }
}

