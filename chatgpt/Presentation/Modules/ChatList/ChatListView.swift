//
//  ChatView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI

struct ChatView: View {
    var viewModel: ChatViewModelProtocol

    var body: some View {
        NavigationView {
            ScrollView {
                ScrollViewReader { value in
                    ForEach(viewModel.chatItems) { item in
                        NavigationLink(destination: ChatDetailBuilder().build()) {
                            ChatMessageView(message: item.message)
                        }.buttonStyle(PlainButtonStyle()) 
                    }
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel())
    }
}
