//
//  ChatCoreDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation
import CoreData

class ChatCoreDataSource: ChatDataSourceProtocol {

    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getMessages() async throws -> [Message] {
        return []
    }

    func getChats() async throws -> [Chat] {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest()
        let sort = NSSortDescriptor(key: "lastUpdated", ascending: false)
        request.returnsObjectsAsFaults = false
        request.sortDescriptors = [sort]
        let chatsCD = try context.fetch(request)
        var chats: [Chat] = []
        for chat in chatsCD {
            chats.append(Chat(with: chat))
        }
        return chats
    }

    func create(with name: String, image: Data?, prompt: String) async throws {
        let chat = ChatCD(context: context)
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
