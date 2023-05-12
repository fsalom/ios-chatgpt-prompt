//
//  GPTRepository.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

protocol GPTRepositoryProtocol {
    func send(this prompt: String, and context: [MessageDTO]) async throws -> MessageDTO?
}

class GPTRepository: GPTRepositoryProtocol {
    var datasource: GPTDataSourceProtocol

    init(datasource: GPTDataSourceProtocol) {
        self.datasource = datasource
    }

    func send(this prompt: String, and context: [MessageDTO]) async throws -> MessageDTO? {
        return try await datasource.send(this: prompt, and: context)
    }
}
