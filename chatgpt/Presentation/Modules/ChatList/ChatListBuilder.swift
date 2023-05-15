//
//  ChatBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

class ChatListBuilder {
    func build() -> ChatListView<ChatListViewModel> {
        let datasource = ChatCoreDataSource()
        let repository = ChatRepository(datasource: datasource)

        let GPTdatasource = GPTDataSource()
        let GPTrepository = GPTRepository(datasource: GPTdatasource)

        let useCase = ChatUseCase(chatRepository: repository, gptRepository: GPTrepository)
        
        let viewModel = ChatListViewModel(useCase: useCase)
        let view = ChatListView(viewModel: viewModel)
        return view
    }
}

