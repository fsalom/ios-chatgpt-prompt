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

    func getMessages(for chatID: String) async throws -> [Message] {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest(for: chatID)
        let chatsCD = try context.fetch(request)
        guard let chat = chatsCD.first else { return [] }

        let messageArray = Array(chat.messages)
        var messages: [Message] = []
        for message in messageArray {
            messages.append(Message(coredata: message as! ChatMessageCD))
        }
        return messages
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
        try context.save()
    }

    func send(this message: String, isSentByUser: Bool, to chatID: String) async throws {
        PersistenceController.shared.whereIsMySQLite()
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest()
        let chatsCD = try context.fetch(request)
        guard let chat = chatsCD.first else { return }
        let chatMessage = ChatMessageCD(context: context)
        chatMessage.id = UUID().uuidString
        chatMessage.content = message
        chatMessage.chatID = chatID
        chatMessage.createdAt = Date()
        chatMessage.isSentByUser = isSentByUser
        let mutableMessages = chat.mutableSetValue(forKey: "messages")
        mutableMessages.add(chatMessage)
        try context.save()
    }
}
