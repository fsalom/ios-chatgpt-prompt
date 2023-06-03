//
//  ChatNewViewModel.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation
import UIKit

class ChatNewViewModel: ChatNewViewModelProtocol {
    @Published var name =  ""
    @Published var prompt =  ""
    @Published var image: Data?

    var chat: Chat?

    var useCase: ChatUseCaseProtocol!

    init(useCase: ChatUseCaseProtocol, chat: Chat? = nil) {
        self.useCase = useCase
        self.chat = chat
        guard let chat else { return }
        self.name = chat.name
        self.prompt = chat.prompt
        self.image = chat.profileImage
    }

    func action() async throws {
        if let _ = chat {
            try await edit()
        } else {
            try await create()
        }
    }

    func create() async throws {
        if image == nil {
            await MainActor.run {
                image = UIImage(named: "logo")?.pngData()
            }
        }
        try await useCase.create(with: name, image: image, prompt: prompt)
    }

    func edit() async throws {
        guard var chat else { return }
        chat.name = name
        chat.prompt = prompt
        if let image {
            chat.profileImage = image
        }
        try await useCase.edit(this: chat)
    }

}
