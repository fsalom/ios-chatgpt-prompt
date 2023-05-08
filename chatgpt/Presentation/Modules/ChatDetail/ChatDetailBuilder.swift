//
//  ChatDetailBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 6/5/23.
//

import Foundation

class ChatDetailBuilder {
    func build() -> ChatDetailView<ChatDetailViewModel> {
        let viewModel = ChatDetailViewModel()
        let view = ChatDetailView(viewModel: viewModel)
        return view
    }
}
