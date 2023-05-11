//
//  ChatDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol ChatDataSourceProtocol {
    func getMessages() async throws -> [ChatMessage]
}


class ChatDataSource: ChatDataSourceProtocol {
    func getMessages() async throws -> [ChatMessage] {
        return [ChatMessage(isSentByUser: true, message: "Hola Chat"),
                ChatMessage(isSentByUser: false, message: "Hola Fer"),
                ChatMessage(isSentByUser: true, message: "Cuanto es 1 + 1?"),
                ChatMessage(isSentByUser: false, message: "el resultado es 2")]
    }
}
