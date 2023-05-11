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
        let useCase = ChatUseCase(repository: repository)

        let viewModel = ChatDetailViewModel(useCase: useCase)
        let view = ChatDetailView(viewModel: viewModel)
        return view
    }
}
