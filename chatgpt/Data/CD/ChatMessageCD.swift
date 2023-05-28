//
//  ChatMessageCD.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 20/5/23.
//

import CoreData

@objc(ChatMessage)
public class ChatMessageCD: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessageCD> {
        return NSFetchRequest<ChatMessageCD>(entityName: "ChatMessage")
    }

    @NSManaged public var id: String
    @NSManaged public var content: String
    @NSManaged public var role: String
    @NSManaged public var createdAt: Date
    @NSManaged public var isSentByUser: Bool
    @NSManaged public var chatID: String
    @NSManaged public var filename: String
    @NSManaged public var isFile: Bool
}
