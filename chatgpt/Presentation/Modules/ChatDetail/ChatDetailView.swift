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
    @State private var scrollToBottom: Bool = false
    @State private var presentImporter: Bool = false
    @FocusState private var isFocused: Bool
    @State private var goToEdit: Bool = false
    @State private var goToImage: Bool = false

    var body: some View {
        ZStack {
            VStack {
                ProgressView(value: viewModel.progress, total: 100.0).tint(viewModel.progress > 100 ? .red : .blue)
                NavigationLink(destination: Image(data: viewModel.chat.profileImage)?.resizable().scaledToFit(), isActive: $goToImage) { EmptyView() }
                NavigationLink(destination: ChatNewBuilder().build(with: viewModel.chat), isActive: $goToEdit) { EmptyView() }
                ScrollViewReader { value in
                    ScrollView {
                        ForEach(viewModel.messages, id: \.id) { message in
                            HStack {
                                if message.isSentByUser { Spacer() }
                                switch message.state {
                                case .success:
                                    ChatMessageView(messageItem: message).id(message.id)
                                case .error:
                                    ChatMessageErrorView(messageItem: message).id(message.id)
                                case .loading:
                                    ChatMessageLoadingView().id(message.id)
                                case .file:
                                    NavigationLink {
                                        ChatFilePreviewer(message: message)
                                    } label: {
                                        ChatMessageFileView(messageItem: message).id(message.id)
                                    }
                                }
                                if !message.isSentByUser { Spacer() }
                            }
                        }
                        .padding(.bottom, 60)
                        .onChange(of: viewModel.messages.count) { _ in
                            scrollToBottom = true
                        }
                    }
                    .onAppear {
                        scrollToBottom = true
                    }
                    .onChange(of: scrollToBottom) { shouldScroll in
                        if shouldScroll {
                            scrollToBottom = false
                            guard let lastMessage = viewModel.messages.last else { return }
                            withAnimation {
                                value.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                if viewModel.isFlushRequired {
                    Button("Limpiar chat") {
                        viewModel.clean()
                        viewModel.isFlushRequired = false
                    }.frame(maxWidth: .infinity, maxHeight: 44, alignment: .center)
                        .background(.red)
                        .foregroundColor(.white)
                }
                if viewModel.getDocuments().count > 0 {
                    ScrollView(.horizontal){
                        HStack {
                            Text("Docs:")
                            ForEach(viewModel.getDocuments()) { message in
                                NavigationLink {
                                    ChatFilePreviewer(message: message)
                                } label: {
                                    Text(message.filename ?? "sin nombre").bubbleStyle()
                                }
                            }
                        }
                    }.padding(5)
                }
                HStack(alignment: viewModel.userNewMessage.isEmpty ? .center : .bottom) {
                    if viewModel.userNewMessage.isEmpty {
                        Button {
                            presentImporter = true
                        } label: {
                            Image(systemName: "plus")
                        }.fileImporter(isPresented: $presentImporter, allowedContentTypes: [.text]) { result in
                            switch result {
                            case .success(let url):
                                viewModel.send(this: url)
                            case .failure(let error):
                                print(error)
                            }
                        }
                    }
                    TextField("Escribe aquí...",
                              text: $viewModel.userNewMessage,
                              axis: .vertical)
                        .lineLimit(4)
                        .focused($isFocused)
                        .onChange(of: isFocused) { isFocused in
                            scrollToBottom = true
                        }
                        .onSubmit {
                            viewModel.send(this: viewModel.userNewMessage)
                        }
                        .padding(10)
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let image = Image(data: viewModel.chat.profileImage) {
                    Button(action: {
                        goToImage = true
                    }) {
                        image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(action: {
                        goToEdit = true
                    }) {
                        Label("Editar", systemImage: "pencil")
                    }
                    Button(action: {
                        viewModel.clean()
                    }) {
                        Label("Eliminar", systemImage: "trash")
                    }
                } label: {
                    Label("Opciones", systemImage: "ellipsis")
                }
            }
        }
    }
}

extension Text {
    func bubbleStyle() -> some View {
        self.padding(10)
            .foregroundColor(.black)
            .background(
                Rectangle()
                    .fill(Color.init(uiColor: .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
            )
            .cornerRadius(15)
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
