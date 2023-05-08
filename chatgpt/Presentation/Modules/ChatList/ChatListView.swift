//
//  ChatView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI
import Foundation

struct ChatView: View {
    var viewModel: ChatViewModelProtocol

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { value in
                    ForEach(viewModel.chatItems) { item in
                        NavigationLink(destination: ChatDetailBuilder().build()) {
                            ChatListMessageView(message: item.message)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Chats")
                .toolbar {
                    ToolbarItem {
                        Button(action: newChat) {
                            Label("Nuevo chat", systemImage: "square.and.pencil")
                                .foregroundColor(.black)
                        }
                    }
                }
        }
    }

    func newChat() {

    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel())
    }
}
