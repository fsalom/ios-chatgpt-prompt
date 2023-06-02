//
//  ChatView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI
import Foundation

struct ChatListView<VM>: View where VM: ChatListViewModelProtocol {
    @ObservedObject var viewModel: VM

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { value in
                    ForEach(viewModel.chats, id: \.id) { chat in
                        NavigationLink(destination: ChatDetailBuilder().build(with: chat)) {
                            ChatListMessageView(chat: chat)
                        }.buttonStyle(PlainButtonStyle())
                    }.onAppear {
                        viewModel.load()
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Chats")
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                            ChatNewBuilder().build()
                        } label: {
                            Label("Nuevo chat", systemImage: "plus")
                                .foregroundColor(.black)
                        }
                    }
                }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListBuilder().build()
    }
}
