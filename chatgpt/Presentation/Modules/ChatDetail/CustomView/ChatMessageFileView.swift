//
//  ChatMessageFileView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 26/5/23.
//

import SwiftUI

struct ChatMessageFileView: View {
    var messageItem: Message
    var body: some View {
        Spacer()
        HStack(alignment: .top) {
            Spacer()
            Text(messageItem.createdAt.formatTime())
                .font(.system(size: 10))
                .foregroundColor(.gray)
            VStack(alignment: .trailing, content: {
                Text(Image(systemName: "doc.fill")).foregroundColor(.blue)
                Text(messageItem.filename ?? "").forUserStyle()
            })
        }.padding(10)
    }
}

struct ChatMessageFileView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageFileView(messageItem: Message(role: "", isSentByUser: true, state: .file, content: ""))
    }
}

fileprivate extension Text {
    func forUserStyle() -> some View {
        self.fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            .padding(10)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .background(
                Rectangle()
                    .fill(Color.init(uiColor: .init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
            )
            .cornerRadius(15, corners: [.bottomLeft, .topLeft, .topRight])
    }
}

fileprivate extension Date {
    func formatTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
