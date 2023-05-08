//
//  ChatListProtocols.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

protocol ChatDetailViewModelProtocol: ObservableObject {
    var userNewMessage: String { get set }
    var messages: [ChatMessage] { get set }
    func sendNewMessage()
}
