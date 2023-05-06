//
//  ChatViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

class ChatViewModel: ObservableObject, ChatViewModelProtocol {
    var chatItems: [ChatItem] = []

    init() {
        self.chatItems.append(contentsOf: [ChatItem(isSentByUser: false, message: "Hola este es un mensaje"),
                                           ChatItem(isSentByUser: false, message: "Adios este es otro mensaje pero más largo para probar el ancho"),
                                           ChatItem(isSentByUser: false, message: "Hola este es corto")])
    }
}
