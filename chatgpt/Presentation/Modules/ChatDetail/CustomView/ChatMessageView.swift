//
//  CharMessageView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import SwiftUI

struct ChatMessageView: View {
    var messageItem: Message
    var body: some View {
        HStack(alignment: .top) {
            if messageItem.isSentByUser {
                Spacer()
                Text(messageItem.createdAt.formatTime())
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }

            Text(messageItem.content ?? "").setStyle(isUser: messageItem.isSentByUser)

            if !messageItem.isSentByUser {
                Text(messageItem.createdAt.formatTime())
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                Spacer()
            }
        }.frame(minWidth: 120, maxWidth: UIScreen.main.bounds.width - 60)
            .padding(10)
    }
}

struct CharMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageView(messageItem: Message(role: "user", isSentByUser: true, state: .success, content: "Mensaje de usuario"))
    }
}


fileprivate extension Text {
    func setStyle(isUser: Bool) -> some View {
        isUser ? AnyView(self.forUserStyle()): AnyView(self.forOtherUserStyle())

    }

    func forUserStyle() -> some View {
        self.fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            .padding(10)
            .foregroundColor(.black)
            .background(
                Rectangle()
                    .fill(Color.init(uiColor: .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
            )
            .cornerRadius(15, corners: [.bottomLeft, .topLeft, .topRight])
    }

    func forOtherUserStyle() -> some View {
        self.fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            .padding(10)
            .foregroundColor(.white)
            .background(
                Rectangle()
                    .fill(Color.blue)
            )
            .cornerRadius(15, corners: [.bottomRight, .topLeft, .topRight])
    }
}

fileprivate extension Date {
    func formatTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
