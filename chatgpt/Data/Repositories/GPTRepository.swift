//
//  GPTRepository.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation

class GPTRepository: GPTRepositoryProtocol {
    var datasource: GPTDataSourceProtocol

    init(datasource: GPTDataSourceProtocol) {
        self.datasource = datasource
    }

    func send(this prompt: String, and context: [MessageDTO]) async throws -> Message? {
        return try await datasource.send(this: prompt, and: context)?.toDomain()
    }
}

fileprivate extension MessageDTO {
    func toDomain() -> Message {
        Message(role: self.role, content: self.content)
    }
}

