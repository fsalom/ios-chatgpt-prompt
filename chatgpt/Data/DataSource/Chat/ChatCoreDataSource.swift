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
        if let chatMessages = chat.messages {
            let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
            let sortedMessages = chatMessages.sortedArray(using: [sortDescriptor]) as! [ChatMessageCD]

            var messages: [Message] = []
            for message in sortedMessages {
                messages.append(Message(coredata: message))
            }
            return messages
        }
        return []
    }

    func getChats() async throws -> [Chat] {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest()
        let sort = NSSortDescriptor(key: "updatedAt", ascending: false)
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
        chat.createdAt = Date()
        chat.updatedAt = Date()
        try context.save()
    }

    func send(this message: Message, to chatID: String) async throws {
        // PersistenceController.shared.whereIsMySQLite()
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest()
        let chatsCD = try context.fetch(request)
        guard let chat = chatsCD.first else { return }
        let chatMessage = ChatMessageCD(context: context)
        chatMessage.id = UUID().uuidString
        chatMessage.role = message.isSentByUser ? "user" : "assistant"
        chatMessage.content = message.content ?? ""
        chatMessage.chatID = chatID
        chatMessage.filename = message.filename ?? ""
        chatMessage.isFile = message.isFile
        chatMessage.createdAt = Date()
        chatMessage.isSentByUser = message.isSentByUser
        chat.updatedAt = Date()
        let mutableMessages = chat.mutableSetValue(forKey: "messages")
        mutableMessages.add(chatMessage)
        try context.save()
    }

    func clean(this chat: Chat) throws {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest(for: chat.id)
        let chatsCD = try context.fetch(request)
        guard let chat = chatsCD.first else { return }
        guard let messages = chat.messages else { return }
        for message in messages {
            context.delete(message as! NSManagedObject)
        }
        try context.save()
    }
}
