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
                        .padding(.bottom, 60)
                    }.onAppear {
                        value.scrollTo(viewModel.messages.last?.id)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        value.scrollTo(viewModel.messages.last?.id)
                    }
                }

                HStack(alignment: viewModel.userNewMessage.isEmpty ? .center : .bottom) {
                    TextField("Escribe aquí...",
                              text: $viewModel.userNewMessage,
                              axis: .vertical).lineLimit(4)
                    .onSubmit {
                        viewModel.send(this: viewModel.userNewMessage)
                    }.padding(10)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 1).fill(Color.gray)
                        )
                        .foregroundColor(.black)


                    if viewModel.userNewMessage.isEmpty {
                        Button("Enviar") {
                            viewModel.send(this: viewModel.userNewMessage)
                        }.disabled(viewModel.userNewMessage.isEmpty)
                    } else {
                        Button {
                            viewModel.send(this: viewModel.userNewMessage)
                        } label: {
                            Image(systemName: "paperplane.fill").rotationEffect(Angle(degrees: 45))
                        } .frame(width: 40, height: 40)
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .disabled(viewModel.userNewMessage.isEmpty)
                    }

                }
                .padding()
                .background(Color.gray.opacity(0.2))
            }
        }.onAppear {
            viewModel.load()
        }
    }
}

struct ChatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ChatDetailBuilder().build(with: Chat(profileImage: Data(),
                                             name: "",
                                             id: "",
                                             prompt: "",
                                             updatedAt: Date(),
                                            createdAt: Date()))
    }
}
