//
//  Chat.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation
import CoreData

@objc(Chat)
public class ChatCD: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatCD> {
        let fetchRequest = NSFetchRequest<ChatCD>(entityName: "Chat")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(for id: String) -> NSFetchRequest<ChatCD> {
        let fetchRequest: NSFetchRequest<ChatCD> = ChatCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.fetchLimit = 1
        return fetchRequest
    }

    @NSManaged public var profileImage: Data
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var prompt: String
    @NSManaged public var updatedAt: Date
    @NSManaged public var createdAt: Date
    @NSManaged public var messages: NSSet?

}
