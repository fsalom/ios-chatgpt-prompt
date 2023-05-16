//
//  ChatCoreDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation
import CoreData

class ChatCoreDataSource: ChatDataSourceProtocol {

    func getMessages() async throws -> [Message] {
        return [Message(role: "user", isSentByUser: true, state: .success, content: "Hola a partir de ahora quiero que actues como si fuera un extraterrestre con un vocabulario muy limitado")]
    }

    func getChats() async throws -> [Chat] {
        let request: NSFetchRequest<Chat> = Chat.fetchRequest()
        let sort = NSSortDescriptor(key: "lastUpdated", ascending: false)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [sort]
        let chats = try PersistenceController.shared.container.viewContext.fetch(request)
        return chats
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        let context = PersistenceController.shared.container.viewContext
        let chat = Chat(context: context)
        chat.id = UUID().uuidString
        chat.name = name
        if let image {
            chat.profileImage = image
        }
        chat.prompt = prompt
        chat.lastUpdated = Date()
        do {
            try context.save()
            print("successfully saved")
        } catch {
            print("Could not save")
        }
    }
}
