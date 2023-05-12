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
                    ForEach(viewModel.chatItems) { item in
                        NavigationLink(destination: ChatDetailBuilder().build()) {
                            ChatListMessageView(chat: item)
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
        let datasource = ChatDataSource()
        let repository = ChatRepository(datasource: datasource)

        let GPTdatasource = GPTDataSource()
        let GPTrepository = GPTRepository(datasource: GPTdatasource)

        let useCase = ChatUseCase(chatRepository: repository, gptRepository: GPTrepository)

        ChatListView(viewModel: ChatListViewModel(useCase: useCase))
    }
}
