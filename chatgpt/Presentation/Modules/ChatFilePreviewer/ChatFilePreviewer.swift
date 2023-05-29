//
//  ChatFilePreviewer.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 28/5/23.
//

import SwiftUI

struct ChatFilePreviewer: View {
    let message: Message
    var body: some View {
        ScrollView {
            Text(message.content ?? "No hay contenido").padding(20)
        }
    }
}

struct ChatFilePreviewer_Previews: PreviewProvider {
    static var previews: some View {
        ChatFilePreviewer(message: Message(error: ""))
    }
}
