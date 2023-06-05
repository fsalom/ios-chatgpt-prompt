//
//  ChatCoreDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case notFound
}

class ChatCoreDataSource: ChatDataSourceProtocol {

    var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func getMessages(for chatID: String) async throws -> [Message] {
        let request: NSFetchRequest<ChatMessageCD> = ChatMessageCD.fetchRequest(for: chatID)
        let messagesCD = try context.fetch(request)
        var messages: [Message] = []
        for message in messagesCD {
            messages.append(Message(coredata: message))
        }
        return messages
    }

    func getChats() async throws -> [Chat] {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest()
        request.returnsObjectsAsFaults = false
        let chatsCD = try context.fetch(request)
        var chats: [Chat] = []
        for chat in chatsCD {
            chats.append(Chat(with: chat))
        }
        return chats
    }

    func getChat(with id: String) async throws -> Chat {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest(for: id)
        let chatsCD = try context.fetch(request)
        guard let chatCD = chatsCD.first else { throw CoreDataError.notFound }
        let chat = Chat(with: chatCD)
        return chat
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

    func edit(this chat: Chat) async throws {
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest(for: chat.id)
        let chatsCD = try context.fetch(request)
        guard let chatCD = chatsCD.first else { return }
        chatCD.name = chat.name
        chatCD.prompt = chat.prompt
        chatCD.profileImage = chat.profileImage
        chatCD.updatedAt = Date()
        try context.save()
    }

    func send(this message: Message, to chatID: String) async throws {
        // PersistenceController.shared.whereIsMySQLite()
        let request: NSFetchRequest<ChatCD> = ChatCD.fetchRequest(for: chatID)
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

        chat.setValue(Date(), forKey: "updatedAt")
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
