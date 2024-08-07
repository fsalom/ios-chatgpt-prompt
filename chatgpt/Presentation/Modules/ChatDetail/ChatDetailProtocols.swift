//
//  ChatListProtocols.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import Foundation

protocol ChatDetailViewModelProtocol: ObservableObject {
    var userNewMessage: String { get set }
    var messages: [Message] { get set }
    var speech: SpeechManager { get set }
    var isFlushRequired: Bool { get set }
    var isRecording: Bool { get set }
    var progress: Float { get set }
    var chat: Chat { get set }
    func send(this message: String)
    func send(this file: URL)
    func getDocuments() -> [Message]
    func clean()
    func load()

    func startRecording()
    func stopRecording()
}
