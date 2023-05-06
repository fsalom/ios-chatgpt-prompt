//
//  ChatMessageView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI

struct ChatMessageView: View {

    var message: String

    var body: some View {
        HStack(alignment: .top) {
            ZStack {

                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 50, height: 50, alignment: .top)

                } placeholder: {
                    ProgressView()
                        .clipShape(Circle())
                        .frame(width: 50, height: 50, alignment: .top)
                }
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.green)
                    .offset(x: 17, y: 17)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text("Fernando Salom")
                    .fontWeight(.bold)
                Text(message)
                    .font(.footnote)
                    .frame(maxHeight: 60, alignment: .top)
                Spacer()
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("10:00")
                Image(systemName: "arrowtriangle.forward.circle.fill")
                    .foregroundColor(.gray)
                    .frame(width: 10, height: 10)
                    .padding(.top, 1)
            }

        }.frame(maxWidth: .infinity, maxHeight: 50)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        Divider().background(Color.gray)
    }

}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(message: "mensaje corto")
        ChatMessageView(message: "esto es un mensaje de prueba largo para probar como se comporta un texto largo")
    }
}
