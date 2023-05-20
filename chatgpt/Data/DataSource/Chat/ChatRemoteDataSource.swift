//
//  ChatDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation
import CoreData

class ChatDataSource: ChatDataSourceProtocol {
    func send(this message: String, isSentByUser: Bool, to chatID: String) async throws {
        
    }

    func getMessages(for chatID: String) async throws -> [Message] {
        return []
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        
    }


    func getChats() async throws -> [Chat] {
        return []
    }
}
