//
//  GPTDataSource.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 11/5/23.
//

import Foundation
import TripleA

protocol GPTDataSourceProtocol {
    func send(this prompt: String, and context: [MessageDTO]) async throws -> MessageDTO?
}


class GPTDataSource: GPTDataSourceProtocol {
    enum ChatError: Error {
        case invalidURL
        case fail
    }

    func send(this prompt: String, and context: [MessageDTO]) async throws -> MessageDTO? {
        let openaiAPIKey = Keys.chatGPT.value
        let parameters = Model(model: "gpt-3.5-turbo", messages: context)
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(openaiAPIKey)"
        ]
        let endpoint = Endpoint(path: "https://api.openai.com/v1/chat/completions",
                                httpMethod: .post,
                                body: try? JSONEncoder().encode(parameters),
                                headers: headers)
        let response = try await Network(baseURL: "").load(endpoint: endpoint,
                                                of: ResponseDTO.self)
        return response.choices.first?.message
    }
}
