//
//  ChatMessageErrorView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 12/5/23.
//

import SwiftUI

struct ChatMessageErrorView: View {
    var body: some View {
        HStack(alignment: .top) {
            Text("Error").error()
        }.frame(minWidth: 120, maxWidth: UIScreen.main.bounds.width - 60)
            .padding(10)
    }
}

struct ChatMessageErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageErrorView()
    }
}

fileprivate extension Text {
    func error() -> some View {
        self.fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.leading)
            .padding(10)
            .foregroundColor(.white)
            .background(
                Rectangle()
                    .fill(Color.red)
            )
            .cornerRadius(15, corners: [.bottomRight, .topLeft, .topRight])
    }
}
