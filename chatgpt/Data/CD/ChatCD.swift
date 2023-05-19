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
        return NSFetchRequest<ChatCD>(entityName: "Chat")
    }

    @NSManaged public var profileImage: Data
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var prompt: String
    @NSManaged public var lastUpdated: Date

    // Other functions and stuff
}


/*
struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let online: Bool
    let profileImage: String
    let lastUpdated: String
    let lastMessage: String
}
 */

