//
//  ChatBuilder.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

class ChatBuilder {
    func build() -> ChatView {
        let viewModel = ChatViewModel()
        let view = ChatView(viewModel: viewModel)
        return view
    }
}
