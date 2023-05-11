//
//  ChatMessageView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 5/5/23.
//

import SwiftUI

struct ChatListMessageView: View {

    var chat: Chat

    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                AsyncImage(url: URL(string: chat.profileImage)) { image in
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
                Text(chat.lastMessage)
                    .font(.footnote)
                    .lineLimit(2)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(chat.lastUpdated).font(.footnote)
            }

        }.frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        Divider().background(Color.gray)
    }


}

struct ChatMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListMessageView(chat: Chat(name: "Fernando Salom",
                                       online: true,
                                       profileImage: "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80",
                                       lastUpdated: "10:01",
                                       lastMessage: "message"))
    }
}
