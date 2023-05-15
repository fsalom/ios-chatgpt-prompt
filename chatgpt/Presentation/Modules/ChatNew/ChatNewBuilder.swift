//
//  ChatNewBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation
import SwiftUI

class ChatNewBuilder {
    func build() -> ChatNewView<ChatNewViewModel> {
        let datasource = ChatCoreDataSource()
        let repository = ChatRepository(datasource: datasource)

        let useCase = ChatUseCase(chatRepository: repository)

        let viewModel = ChatNewViewModel(useCase: useCase)
        let view = ChatNewView(viewModel: viewModel)
        return view
    }
}
