//
//  ChatProtocols.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 20/5/23.
//

import Foundation

protocol ChatDataSourceProtocol {
    func getMessages() async throws -> [Message]
    func getChats() async throws -> [Chat]
    func create(with name: String, image: Data?, prompt: String) async throws
}
