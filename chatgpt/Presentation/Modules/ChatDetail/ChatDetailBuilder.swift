//
//  ChatDetailBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 6/5/23.
//

import Foundation

class ChatDetailBuilder {
    func build(with chat: Chat) -> ChatDetailView<ChatDetailViewModel> {
        let datasource = ChatCoreDataSource(context: PersistenceController.shared.container.viewContext)
        let repository = ChatRepository(datasource: datasource)

        let GPTdatasource = GPTDataSource()
        let GPTrepository = GPTRepository(datasource: GPTdatasource)

        let useCase = ChatUseCase(chatRepository: repository, gptRepository: GPTrepository)

        let viewModel = ChatDetailViewModel(with: chat, and: useCase)
        let view = ChatDetailView(viewModel: viewModel)
        return view
    }
}
