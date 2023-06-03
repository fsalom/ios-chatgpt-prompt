//
//  SplashView.swift
//  chatgpt
//
//  Created by Fernando Salom Carratala on 2/6/23.
//

import SwiftUI

struct SplashView: View {

    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            Color.white
            if self.isActive {
                ChatListBuilder().build()
            } else {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }

}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
