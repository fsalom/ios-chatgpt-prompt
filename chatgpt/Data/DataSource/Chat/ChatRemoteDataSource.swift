//
//  ChatDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation
import CoreData

class ChatDataSource: ChatDataSourceProtocol {
    func getMessages() async throws -> [Message] {
        return []
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        
    }


    func getChats() async throws -> [Chat] {
        return []
    }
}