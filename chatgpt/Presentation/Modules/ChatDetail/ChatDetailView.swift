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

    let backgroundGradient = Color.init(UIColor(red: 245, green: 247, blue: 251, alpha: 1))

    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()

            ScrollView {
                ScrollViewReader { value in
                    ForEach(viewModel.messages) { message in
                        HStack {
                            if message.isSentByUser { Spacer() }
                            CharMessageView(messageItem: message)
                            if !message.isSentByUser { Spacer() }
                        }
                    }
                    .onChange(of: viewModel.messages) { _ in
                        value.scrollTo(viewModel.messages.last?.id)
                    }
                    .padding(.bottom, 60) // Ajusta el valor de la almohadilla inferior según sea necesario
                }
            }

            VStack {
                Spacer()
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
        let useCase = ChatUseCase(repository: repository)

        ChatDetailView(viewModel: ChatDetailViewModel(useCase: useCase))
    }
}
