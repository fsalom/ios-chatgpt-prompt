//
//  ChatMessageLoadingView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 12/5/23.
//

import SwiftUI
import Lottie

struct ChatMessageLoadingView: View {
    var body: some View {
        HStack(alignment: .top) {
            LottieView(lottieFile: "simple-loading").frame(width: 200, height: 60)

            Text("12:00")
                .font(.system(size: 10))
                .foregroundColor(.gray)
            Spacer()

        }.frame(minWidth: 120, maxWidth: UIScreen.main.bounds.width - 60)
            .padding(10)
    }
}

struct ChatMessageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMessageLoadingView()
    }
}

struct LottieView: UIViewRepresentable {

    var lottieFile: String
    var loopMode: LottieLoopMode = .loop
    var animationView = LottieAnimationView()

    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView()

        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}

fileprivate extension Text {
    func loading() -> some View {
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
