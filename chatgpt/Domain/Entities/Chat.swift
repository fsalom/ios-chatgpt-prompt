//
//  Chat.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

struct Chat: Identifiable {
    let id = UUID()
    let name: String
    let online: Bool
    let profileImage: String
    let lastUpdated: String
    let lastMessage: String
}
