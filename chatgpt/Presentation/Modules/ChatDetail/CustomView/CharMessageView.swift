//
//  CharMessageView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 8/5/23.
//

import SwiftUI

struct CharMessageView: View {
    var messageItem: ChatMessage
    var body: some View {
        HStack(alignment: .center) {
            if messageItem.isSentByUser {
                Spacer()
                Text("10:00")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
            }

            Text(messageItem.message).setStyle(isUser: messageItem.isSentByUser)

            if !messageItem.isSentByUser {
                Text("12:00")
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
        CharMessageView(messageItem: ChatMessage(isSentByUser: true, message: "Mensaje de usuario"))
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

fileprivate struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner

    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

fileprivate extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
