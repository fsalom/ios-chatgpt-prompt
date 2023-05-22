//
//  ChatDetailBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 6/5/23.
//

import Foundation
import TripleA

class ChatDetailBuilder {
    func build(with chat: Chat) -> ChatDetailView<ChatDetailViewModel> {
        let datasource = ChatCoreDataSource(context: PersistenceController.shared.container.viewContext)
        let repository = ChatRepository(datasource: datasource)

        let GPTdatasource = GPTDataSource(network: Network(baseURL: "https://api.openai.com/v1/chat/"))
        let GPTrepository = GPTRepository(datasource: GPTdatasource)

        let useCase = ChatUseCase(chatRepository: repository, gptRepository: GPTrepository)

        let viewModel = ChatDetailViewModel(with: chat, and: useCase)
        let view = ChatDetailView(viewModel: viewModel)
        return view
    }
}
