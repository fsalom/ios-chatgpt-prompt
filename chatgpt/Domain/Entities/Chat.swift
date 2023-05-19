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
    var lastUpdated: Date

    init(with coredata: ChatCD) {
        self.profileImage = coredata.profileImage
        self.id = coredata.id
        self.name = coredata.name
        self.prompt = coredata.prompt
        self.lastUpdated = coredata.lastUpdated
    }

    init(profileImage: Data, name: String, id: String, prompt: String, lastUpdated: Date) {
        self.profileImage = profileImage
        self.id = id
        self.name = name
        self.prompt = prompt
        self.lastUpdated = lastUpdated
    }
}
