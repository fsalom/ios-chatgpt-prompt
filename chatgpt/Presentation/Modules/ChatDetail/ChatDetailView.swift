//
//  ChatDetailView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 6/5/23.
//

import SwiftUI
import Foundation

struct ChatDetailView<VM>: View where VM: ChatDetailViewModelProtocol  {
    @ObservedObject var viewModel: VM

    var body: some View {
        ZStack {
            VStack {
                ScrollViewReader { value in
                    ScrollView {
                        ForEach(viewModel.messages, id: \.id) { message in
                            HStack {
                                if message.isSentByUser { Spacer() }
                                switch message.state {
                                case .success:
                                    ChatMessageView(messageItem: message).id(message.id)
                                case .error:
                                    ChatMessageErrorView().id(message.id)
                                case .loading:
                                    ChatMessageLoadingView()
                                }
                                if !message.isSentByUser { Spacer() }
                            }
                        }
                        .padding(.bottom, 60) // Ajusta el valor de la almohadilla inferior según sea necesario
                    }.onAppear {
                        value.scrollTo(viewModel.messages.last?.id)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        value.scrollTo(viewModel.messages.last?.id)
                    }
                }

                HStack {
                    TextField("Escribe aquí...",
                              text: $viewModel.userNewMessage)
                    .onSubmit {
                        viewModel.sendNewMessage()
                    }
                    Button("Enviar") {
                        viewModel.sendNewMessage()
                    }
                    .disabled(viewModel.userNewMessage.isEmpty)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
        }
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let datasource = ChatDataSource()
        let repository = ChatRepository(datasource: datasource)

        let GPTdatasource = GPTDataSource()
        let GPTrepository = GPTRepository(datasource: GPTdatasource)

        let useCase = ChatUseCase(chatRepository: repository, gptRepository: GPTrepository)
        let prompt = "example"
        ChatDetailView(viewModel: ChatDetailViewModel(with: prompt,
                                                      and: useCase))
    }
}
