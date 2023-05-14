//
//  ChatNewViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation


class ChatNewViewModel: ChatNewViewModelProtocol {
    @Published var name =  ""
    @Published var prompt =  ""

    var useCase: ChatUseCaseProtocol!

    init(useCase: ChatUseCaseProtocol) {
        self.useCase = useCase
    }

    func create() async throws {
        do {
            try await useCase.create(with: name, image: Data(), prompt: prompt)
        } catch {
            print(error)
        }
    }
}
