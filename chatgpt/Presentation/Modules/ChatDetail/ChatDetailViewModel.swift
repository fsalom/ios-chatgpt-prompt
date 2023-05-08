//
//  ChatDetailViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

class ChatDetailViewModel: ChatDetailViewModelProtocol {
    @Published var userNewMessage =  ""
    @Published var messages: [ChatMessage] = []

    init() {
        self.messages.append(contentsOf: [ChatMessage(isSentByUser: false, message: "Hola este es un mensaje"),
                                           ChatMessage(isSentByUser: true, message: "Adios este es otro mensaje pero más largo para probar el ancho"),
                                           ChatMessage(isSentByUser: false, message: "Hola este es corto")])
    }

    func sendNewMessage() {
        self.messages.append(ChatMessage(isSentByUser: true, message: userNewMessage))
        userNewMessage = ""
    }
}
