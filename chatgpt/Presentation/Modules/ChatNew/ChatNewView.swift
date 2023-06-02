//
//  ChatNewView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 13/5/23.
//

import SwiftUI
import PhotosUI

struct ChatNewView<VM>: View where VM: ChatNewViewModelProtocol  {
    @ObservedObject var viewModel: VM
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @Environment(\.dismiss) var dismiss

    var body: some View {

        Form {
            Section("Nombre del chat") {
                HStack {
                    PhotosPicker(selection: $avatarItem, photoLibrary: .shared()) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                            if let avatarImage {
                                avatarImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }else{
                                if let image = viewModel.image {
                                    Image(data: image)!
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "camera")
                                        .foregroundColor(.white)
                                        .imageScale(.small)
                                        .frame(width: 44, height: 40)
                                }
                            }
                        }.padding()
                    }
                    TextField("Nombre del chat", text: $viewModel.name)
                }
            }
            Section("Prompt") {
                TextEditor(text: $viewModel.prompt)
            }

        }.toolbar {
            ToolbarItem {
                Button("Guardar") {
                    Task {
                        do {
                            try await viewModel.action()
                            dismiss()
                        } catch {

                        }
                    }
                }
            }
        }.onChange(of: avatarItem) { _ in
            Task {
                if let data = try? await avatarItem?.loadTransferable(type: Data.self) {
                    viewModel.image = data
                    if let uiImage = UIImage(data: data) {
                        avatarImage = Image(uiImage: uiImage)
                        return
                    }
                }

                print("Failed")
            }
        }
    }
}



struct ChatNewView_Previews: PreviewProvider {

    static var previews: some View {
        let datasource = ChatDataSource()
        let repository = ChatRepository(datasource: datasource)

        let useCase = ChatUseCase(chatRepository: repository)
        let vm = ChatNewViewModel(useCase: useCase)
        ChatNewView(viewModel: vm)
    }
}

fileprivate extension Image {
    func toUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view


        let renderer = UIGraphicsImageRenderer(size: view!.bounds.size)
        let image = renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }

        return image
    }
}
