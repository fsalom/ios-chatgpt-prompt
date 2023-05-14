//
//  ChatNewProtocols.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import Foundation

protocol ChatNewViewModelProtocol: ObservableObject {
    var name: String { get set }
    var prompt: String { get set }
    func create() async throws
}
