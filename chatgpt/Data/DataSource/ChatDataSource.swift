//
//  ChatDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation
import CoreData

protocol ChatDataSourceProtocol {
    func getMessages() async throws -> [Message]
    func getChats() async throws -> [Chat]
    func create(with name: String, image: Data?, prompt: String) async throws
}


class ChatDataSource: ChatDataSourceProtocol {
    func getMessages() async throws -> [Message] {
        return [Message(role: "user", isSentByUser: true, state: .success, content: "Hola a partir de ahora quiero que actues como si fuera un extraterrestre con un vocabulario muy limitado")]
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        
    }


    func getChats() async throws -> [Chat] {
        return []
    }
}
