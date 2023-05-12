//
//  ChatDetailBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 6/5/23.
//

import Foundation

class ChatDetailBuilder {
    func build() -> ChatDetailView<ChatDetailViewModel> {
        let datasource = ChatDataSource()
        let repository = ChatRepository(datasource: datasource)

        let GPTdatasource = GPTDataSource()
        let GPTrepository = GPTRepository(datasource: GPTdatasource)

        let useCase = ChatUseCase(chatRepository: repository, gptRepository: GPTrepository)

        let viewModel = ChatDetailViewModel(useCase: useCase)
        let view = ChatDetailView(viewModel: viewModel)
        return view
    }
}
