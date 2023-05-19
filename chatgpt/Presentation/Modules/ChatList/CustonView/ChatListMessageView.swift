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
                if let image = Image(data: chat.profileImage) {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 50, height: 50, alignment: .top)
                } else {
                    Circle()
                        .frame(width: 50, height: 50, alignment: .top)
                        .foregroundColor(.gray)
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                        .imageScale(.small)
                        .frame(width: 44, height: 40)

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
        ChatListMessageView(chat: Chat(profileImage: Data(), name: "", id: "", prompt: "", lastUpdated: Date()))
    }
}
