//
//  ChatProtocols.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import Foundation

protocol ChatListViewModelProtocol: ObservableObject  {
    var chats: [Chat] { get set }
    func load()
}
