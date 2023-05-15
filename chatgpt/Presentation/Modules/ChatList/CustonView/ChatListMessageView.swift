//
//  ChatMessageView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI
import CoreData

struct ChatListMessageView: View {

    var chat: Chat

    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                AsyncImage(url: URL(string: "chat.image")) { image in
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
                    .strokeBorder(Color.white,lineWidth: 2)
                    .background(Circle().foregroundColor(Color.green))
                    .frame(width: 10, height: 10)
                    .offset(x: 17, y: 17)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(chat.name)
                    .fontWeight(.bold)
                Text(chat.prompt)
                    .font(.footnote)
                    .lineLimit(2)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(chat.lastUpdated.formatted(.relative(presentation: .named))).font(.footnote)
            }

        }.frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        Divider().background(Color.gray)
    }


}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListMessageView(chat: Chat(context: PersistenceController.shared.container.viewContext))
    }
}
