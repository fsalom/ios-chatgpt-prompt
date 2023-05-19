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

    init(cD: ChatCD) {
        self.profileImage = cD.profileImage
        self.id = cD.id
        self.name = cD.name
        self.prompt = cD.prompt
        self.lastUpdated = cD.lastUpdated
    }

    init(profileImage: Data, name: String, id: String, prompt: String, lastUpdated: Date) {
        self.profileImage = profileImage
        self.id = id
        self.name = name
        self.prompt = prompt
        self.lastUpdated = lastUpdated
    }
}
