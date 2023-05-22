//
//  Chat.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 19/5/23.
//

import Foundation


struct Chat: Identifiable {
    var profileImage: Data
    var id: String
    var name: String
    var prompt: String
    var updatedAt: Date
    var createdAt: Date

    init(with coredata: ChatCD) {
        self.profileImage = coredata.profileImage
        self.id = coredata.id
        self.name = coredata.name
        self.prompt = coredata.prompt
        self.updatedAt = coredata.updatedAt
        self.createdAt = coredata.createdAt
    }

    init(profileImage: Data, name: String, id: String, prompt: String, updatedAt: Date, createdAt: Date) {
        self.profileImage = profileImage
        self.id = id
        self.name = name
        self.prompt = prompt
        self.updatedAt = updatedAt
        self.createdAt = createdAt
    }
}
